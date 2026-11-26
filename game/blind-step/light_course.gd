extends Node3D

const Player = preload("res://player.gd")
const Lamp = preload("res://flashlight.gd")
const ATLAS_WIDTH := 128
const SPACING := 0.45
const SAMPLE_INTERVAL := 0.1
const TORCH_SAMPLE_INTERVAL := 1.0 / 30.0
const FULL_EXPOSURE := 3.0
const MATCH_TRACE_SECONDS := 1.4
const TRACE_SECONDS := 5.0
@onready var player: Player = $PlayerSpawn/Player
@onready var lamp: Lamp = player.get_node("Camera3D/Flashlight")
var points := PackedVector3Array()
var normals := PackedVector3Array()
var colors := PackedColorArray()
var coordinates := PackedVector2Array()
var face_layout := PackedFloat32Array()
var triangles := PackedInt32Array()
var exposure: Image
var exposure_texture: ImageTexture
var material := ShaderMaterial.new()
var elapsed := 0.0
var trace_until := 0.0
var until_sample := 0.0
var previous_source := 0
var previous_sample := 0.0
var sample_number := 1
var last_seen := PackedInt32Array()
var dwell := PackedFloat32Array()

func _ready() -> void:
	# Authored box colliders also define the surfaces used by the light-memory pass.
	for child in $Geometry.get_children():
		var collider := child as CollisionShape3D
		var size := (collider.shape as BoxShape3D).size
		for axis in [Vector3.RIGHT, Vector3.UP, Vector3.BACK]:
			build_face(collider.position, size, axis, collider.name)
			build_face(collider.position, size, -axis, collider.name)
	var arrays := []
	last_seen.resize(points.size())
	dwell.resize(points.size())
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = points
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_COLOR] = colors
	arrays[Mesh.ARRAY_TEX_UV] = coordinates
	arrays[Mesh.ARRAY_CUSTOM0] = face_layout
	arrays[Mesh.ARRAY_INDEX] = triangles
	var mesh := ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays, [], {}, Mesh.ARRAY_CUSTOM_RGB_FLOAT << Mesh.ARRAY_FORMAT_CUSTOM0_SHIFT)
	exposure = Image.create_empty(ATLAS_WIDTH, ceili(float(points.size()) / ATLAS_WIDTH), false, Image.FORMAT_RGBAF)
	exposure.fill(Color(0, 0, 0, 0))
	exposure_texture = ImageTexture.create_from_image(exposure)
	material.shader = preload("res://surface_memory.gdshader")
	material.set_shader_parameter("exposure_map", exposure_texture)
	material.set_shader_parameter("trace_limits", Vector2(MATCH_TRACE_SECONDS, TRACE_SECONDS))
	$Surfaces.mesh = mesh
	$Surfaces.material_override = material

func build_face(center: Vector3, size: Vector3, normal: Vector3, object_name: String) -> void:
	var u := Vector3.RIGHT if normal.x == 0 else Vector3.BACK
	var v := u.cross(normal)
	var width := size.dot(u.abs())
	var height := size.dot(v.abs())
	var nx := maxi(1, ceili(width / SPACING))
	var ny := maxi(1, ceili(height / SPACING))
	var origin := center + normal * size.dot(normal.abs()) * 0.5 - (u * width + v * height) * 0.5
	var tint := Color(0.37, 0.39, 0.40)
	if object_name.contains("Floor"):
		tint = Color(0.23, 0.25, 0.26)
	elif object_name.begins_with("Crate") or object_name.begins_with("Shelf"):
		tint = Color(0.42, 0.31, 0.21)
	var first_sample := points.size()
	for y in range(ny + 1):
		for x in range(nx + 1):
			var i := points.size()
			points.append(origin + u * width * x / nx + v * height * y / ny)
			normals.append(normal)
			colors.append(tint)
			coordinates.append(Vector2(x, y))
			face_layout.append(first_sample)
			face_layout.append(nx + 1)
			face_layout.append(ny + 1)
			if x < nx and y < ny:
				triangles.append_array(PackedInt32Array([i, i+1, i+nx+1, i+1, i+nx+2, i+nx+1]))

func _physics_process(delta: float) -> void:
	elapsed += delta
	material.set_shader_parameter("clock_seconds", elapsed)
	if player.global_position.z < -19.5:
		lamp.equip_torch()
	var source := 0
	if lamp.burn_left > 0.0:
		source = 1
	elif lamp.light_energy > 0.0:
		source = 2
	until_sample -= delta
	if source != 0 and (source != previous_source or until_sample <= 0.0):
		var interval := 0.0
		sample_number += 1
		if previous_source == source:
			interval = elapsed - previous_sample
		else:
			sample_number += 1 # A new source or switch-on starts a new exposure.
		previous_sample = elapsed
		record_light(source == 2, interval)
		until_sample = TORCH_SAMPLE_INTERVAL if source == 2 else SAMPLE_INTERVAL
	previous_source = source

func record_light(torch: bool, interval: float) -> void:
	var light_position := lamp.global_position
	var forward := -lamp.global_basis.z
	var reach := lamp.spot_range if torch else lamp.flame.omni_range
	var cutoff := cos(deg_to_rad(lamp.spot_angle))
	var space := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.new()
	query.from = light_position
	query.exclude = [player.get_rid()]
	for i in range(points.size()):
		var offset := points[i] - light_position
		if offset.length_squared() > reach * reach or normals[i].dot(offset) >= 0.0:
			continue
		if torch and forward.dot(offset.normalized()) < cutoff:
			continue
		query.to = points[i] + normals[i] * 0.015
		if not space.intersect_ray(query).is_empty():
			continue
		var x := i % ATLAS_WIDTH
		var y := floori(float(i) / ATLAS_WIDTH)
		var stamp := exposure.get_pixel(x, y)
		var strength := 1.0 - smoothstep(reach * 0.35, reach, offset.length())
		if torch:
			var ray := offset.normalized()
			strength *= smoothstep(cutoff, 1.0, forward.dot(ray))
			strength *= maxf(0.0, normals[i].dot(-ray))
		if last_seen[i] == sample_number - 1:
			dwell[i] = minf(FULL_EXPOSURE, dwell[i] + interval * strength)
		else:
			dwell[i] = 0.0
		last_seen[i] = sample_number
		var limit := TRACE_SECONDS if torch else MATCH_TRACE_SECONDS
		var lifetime := limit * strength * dwell[i] / FULL_EXPOSURE
		var expiry := elapsed + lifetime
		if lifetime <= 0.0:
			continue
		if torch and expiry > stamp.g:
			stamp.g = expiry
			stamp.a = lifetime
		elif not torch and expiry > stamp.r:
			stamp.r = expiry
			stamp.b = lifetime
		exposure.set_pixel(x, y, stamp)
	exposure_texture.update(exposure)
	trace_until = maxf(trace_until, elapsed + (TRACE_SECONDS if torch else MATCH_TRACE_SECONDS))
	material.set_shader_parameter("trace_until", trace_until)

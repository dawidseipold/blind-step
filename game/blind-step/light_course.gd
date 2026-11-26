extends Node3D

const Player = preload("res://player.gd")
const Lamp = preload("res://match_light.gd")
@onready var player: Player = $PlayerSpawn/Player
@onready var lamp: Lamp = player.get_node("Camera3D/Match")
@onready var camera: Camera3D = player.camera
var points := PackedVector3Array()
var normals := PackedVector3Array()
var colors := PackedColorArray()
var triangles := PackedInt32Array()

func _ready() -> void:
	if has_node("Manor"):
		$Manor.build($Geometry)
	for child in $Geometry.get_children():
		var collider := child as CollisionShape3D
		var size := (collider.shape as BoxShape3D).size
		for axis in [Vector3.RIGHT, Vector3.UP, Vector3.BACK]:
			build_face(collider.position, size, axis, collider.name)
			build_face(collider.position, size, -axis, collider.name)
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = points
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_COLOR] = colors
	arrays[Mesh.ARRAY_INDEX] = triangles
	var mesh := ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	var material := ShaderMaterial.new()
	material.shader = preload("res://course_surface.gdshader")
	material.set_shader_parameter("manor", has_node("Manor"))
	$Surfaces.mesh = mesh
	$Surfaces.material_override = material
	$Diagnostics/Tuning.initialize()
	$Observer.initialize()

func build_face(center: Vector3, size: Vector3, normal: Vector3, object_name: String) -> void:
	var u := Vector3.RIGHT if normal.x == 0 else Vector3.BACK
	var v := u.cross(normal)
	var width := size.dot(u.abs())
	var height := size.dot(v.abs())
	var origin := center + normal * size.dot(normal.abs()) * 0.5 - (u * width + v * height) * 0.5
	var tint := Color(0.37, 0.39, 0.40)
	if object_name.contains("Floor"):
		tint = Color(0.23, 0.25, 0.26)
	elif object_name.begins_with("Crate") or object_name.begins_with("Shelf"):
		tint = Color(0.42, 0.31, 0.21)
	for y in range(2):
		for x in range(2):
			var i := points.size()
			points.append(origin + u * width * x + v * height * y)
			normals.append(normal)
			colors.append(tint)
			if x == 0 and y == 0:
				triangles.append_array(PackedInt32Array([i, i+1, i+2, i+1, i+3, i+2]))

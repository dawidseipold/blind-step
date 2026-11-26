extends Node3D

var walnut := StandardMaterial3D.new()
var brass := StandardMaterial3D.new()
var wax := StandardMaterial3D.new()
var velvet := StandardMaterial3D.new()

func build(geometry: StaticBody3D) -> void:
	walnut.albedo_color = Color("#643d2b")
	brass.albedo_color = Color("#bc9254")
	brass.metallic = 0.45
	brass.roughness = 0.42
	wax.emission_enabled = true
	wax.emission = Color("#ffbf68")
	wax.emission_energy_multiplier = 4.0
	velvet.albedo_color = Color("#762e23")
	for side in [-1, 1]:
		var x := float(side) * 6.78
		for height in [0.18, 1.32, 3.38, 5.82]:
			block(Vector3(x,height,0), Vector3(0.18,0.12,19.8), walnut)
		for z in range(-9,10):
			block(Vector3(x,0.72,z), Vector3(0.10,1.05,0.065), walnut)
		for z in [-8,-3,2,7]:
			column(Vector3(x,0,z))
			if side == -1:
				block(Vector3(0,5.78,z), Vector3(13.6,0.24,0.28), walnut)
	# A rising west stair connects the floor to the gallery at the back.
	for i in range(18):
		var h := (i+1)*0.18
		var pos := Vector3(-5.25,h*0.5,2.6-i*0.40)
		block(pos,Vector3(2.65,h,0.40),walnut)
		block(Vector3(pos.x,h+0.012,pos.z),Vector3(1.35,0.022,0.40),velvet)
		if i % 2 == 0:
			spindle(Vector3(-3.97,h,pos.z))
	var rail := block(Vector3(-3.97,2.68,-0.8), Vector3(0.13,0.11,7.85), walnut)
	rail.rotation.x = atan(0.18/0.4)
	var ramp := StaticBody3D.new()
	add_child(ramp)
	var ramp_shape := CollisionShape3D.new()
	var prism := ConvexPolygonShape3D.new()
	var vertices := PackedVector3Array()
	for x in [-6.58,-3.92]:
		vertices.append_array([Vector3(x,-0.1,2.8),Vector3(x,0.0,2.8),Vector3(x,3.24,-4.4),Vector3(x,-0.1,-4.4)])
	prism.points = vertices
	ramp_shape.shape = prism
	ramp.add_child(ramp_shape)
	var landing := CollisionShape3D.new()
	landing.name = "GalleryPlatform"
	var deck := BoxShape3D.new()
	deck.size = Vector3(13.65,0.28,5.4)
	landing.shape = deck
	landing.position = Vector3(0,3.10,-7.1)
	geometry.add_child(landing)
	block(Vector3(1.51,4.19,-4.45),Vector3(10.65,0.13,0.16),walnut)
	for i in range(21):
		spindle(Vector3(-3.65+i*0.51,3.24,-4.45))
	# Back gallery doors outlined by raised panels and a cut-stone lintel.
	for side in [-1,1]:
		var x := float(side)*0.58
		block(Vector3(x,4.44,-9.78),Vector3(1.12,2.4,0.13),walnut)
		for h in [3.84,4.97]:
			block(Vector3(x,h,-9.67),Vector3(0.82,0.89,0.09),brass)
			block(Vector3(x,h,-9.61),Vector3(0.74,0.80,0.07),walnut)
	block(Vector3(0,5.69,-9.69),Vector3(2.72,0.17,0.31),brass)
	# A recessed-looking pair of doors marks the dark bay beneath the gallery.
	for side in [-1,1]:
		var x := 1.0 + float(side)*0.52
		block(Vector3(x,1.18,-4.70),Vector3(1.01,2.36,0.12),walnut)
		for h in [0.62,1.68]:
			block(Vector3(x,h,-4.61),Vector3(0.79,0.85,0.07),brass)
			block(Vector3(x,h,-4.56),Vector3(0.73,0.79,0.05),walnut)
		block(Vector3(1.0+float(side)*1.14,1.28,-4.68),Vector3(0.18,2.56,0.25),walnut)
	block(Vector3(1,2.57,-4.66),Vector3(2.5,0.18,0.3),walnut)
	# Keep the low slide canopy clear. The settee rests beside the east wall.
	var seat := CollisionShape3D.new()
	seat.name = "Settee"
	var seat_shape := BoxShape3D.new()
	seat_shape.size = Vector3(2.35,0.58,0.89)
	seat.shape = seat_shape
	seat.position = Vector3(5.35,0.29,6.8)
	geometry.add_child(seat)
	block(Vector3(5.35,0.47,6.8),Vector3(2.35,0.27,0.83),velvet)
	block(Vector3(5.35,0.78,7.17),Vector3(2.35,0.63,0.16),velvet)
	for side in [-1,1]:
		block(Vector3(5.35+side*1.12,0.56,6.8),Vector3(0.14,0.35,0.89),walnut)
		for z in [6.5,7.1]:
			turned(Vector3(5.35+side*1.02,0.16,z),0.32,0.06,0.045,walnut)
	chandelier(Vector3(0,3.92,-1.2))
	for x in [-6.5,6.5]:
		for z in [-6,4]:
			block(Vector3(x,2.33,z),Vector3(0.35,0.13,0.16),brass)
			candle(Vector3(x*0.98,2.48,z))
			firelight(Vector3(x*0.94,2.7,z),1.1,8.0)

func mesh_at(pos: Vector3, mesh: Mesh, mat: Material) -> MeshInstance3D:
	var node := MeshInstance3D.new()
	node.mesh = mesh
	node.material_override = mat
	node.position = pos
	add_child(node)
	return node

func block(pos: Vector3, size: Vector3, mat: Material) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	return mesh_at(pos,mesh,mat)

func turned(pos: Vector3, height: float, top: float, bottom: float, mat: Material) -> void:
	var mesh := CylinderMesh.new()
	mesh.height = height
	mesh.top_radius = top
	mesh.bottom_radius = bottom
	mesh.radial_segments = 10
	mesh.rings = 0
	mesh_at(pos,mesh,mat)

func column(base: Vector3) -> void:
	turned(base+Vector3.UP*2.90,5.60,0.15,0.23,walnut)
	for h in [0.26,1.32,3.38,5.64]:
		turned(base+Vector3.UP*h,0.18,0.32,0.31,brass)

func spindle(base: Vector3) -> void:
	turned(base+Vector3.UP*0.45,0.90,0.048,0.075,walnut)
	turned(base+Vector3.UP*0.40,0.25,0.09,0.065,brass)

func candle(pos: Vector3) -> void:
	turned(pos,0.22,0.055,0.065,brass)
	turned(pos+Vector3.UP*0.15,0.15,0.006,0.045,wax)

func chandelier(pos: Vector3) -> void:
	turned(Vector3(pos.x,5.0,pos.z),2.05,0.028,0.028,brass)
	for tier in range(2):
		var radius := 0.86-tier*0.34
		var center := pos+Vector3.UP*tier*0.53
		var ring := TorusMesh.new()
		ring.inner_radius = radius-0.075
		ring.outer_radius = radius+0.075
		ring.rings = 24
		ring.ring_segments = 8
		mesh_at(center,ring,brass)
		for i in range(8):
			var offset := Vector3(cos(i*TAU/8),0,sin(i*TAU/8))*radius
			candle(center+offset+Vector3.UP*0.13)
			if i % 2 == 0:
				var arm := block(center+offset*0.5, Vector3(0.055,0.065,radius),brass)
				arm.rotation.y = atan2(offset.x,offset.z)
	firelight(pos+Vector3.DOWN*0.23,2.6,14.0)

func firelight(pos: Vector3, power: float, reach: float) -> void:
	var light := OmniLight3D.new()
	light.position = pos
	light.light_color = Color("#ffbd79")
	light.light_energy = power
	light.light_size = 0.16
	light.omni_attenuation = 1.35
	light.omni_range = reach
	light.shadow_enabled = true
	add_child(light)


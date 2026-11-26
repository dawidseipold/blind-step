extends Marker3D

# Fixed observer for the lighting playtest. Only physics geometry blocks sight.
var state := "Cień"
var notice := 0.0
var exposure := 0.0
var until_sample := 0.0
var sources: Array[Light3D] = []
@onready var course = get_parent()
var query := PhysicsRayQueryParameters3D.new()

func initialize() -> void:
	query.exclude = [course.player.get_rid()]
	for node in course.find_children("*", "Light3D", true, false):
		if node is OmniLight3D or node is SpotLight3D:
			sources.append(node)

func _physics_process(delta: float) -> void:
	until_sample -= delta
	if until_sample <= 0.0:
		until_sample = 0.1
		sample_visibility()
	if state == "Na widoku":
		notice = minf(1.0, notice + delta * lerpf(0.4, 0.9, exposure))
	else:
		notice = maxf(0.0, notice - delta * 0.65)

func clear_path(origin: Vector3, target: Vector3) -> bool:
	query.from = origin
	query.to = target
	return get_world_3d().direct_space_state.intersect_ray(query).is_empty()

func sample_visibility() -> void:
	var eye: Vector3 = course.camera.global_position
	var chest: Vector3 = course.player.global_position.lerp(eye, 0.58)
	var env: Environment = course.get_node("Environment").environment
	var ambient := env.ambient_light_energy * env.ambient_light_color.get_luminance()
	var seen := false
	exposure = 0.0
	for point: Vector3 in [eye, chest]:
		if not clear_path(global_position, point):
			continue
		seen = true
		var brightness := ambient
		for light in sources:
			if light.is_visible_in_tree():
				brightness += illumination(light, point)
		exposure = maxf(exposure, clampf(brightness, 0.0, 1.0))
	if not seen:
		state = "Za osłoną"
	elif exposure >= 0.16:
		state = "Na widoku"
	else:
		state = "Cień"

func illumination(light: Light3D, point: Vector3) -> float:
	var offset := point - light.global_position
	var distance := offset.length()
	var reach := light.get_param(Light3D.PARAM_RANGE)
	if distance >= reach:
		return 0.0
	var factor := 1.0 - smoothstep(reach * 0.70, reach, distance)
	if light is SpotLight3D:
		var cosine := -light.global_basis.z.dot(offset.normalized())
		factor *= smoothstep(cos(deg_to_rad(light.spot_angle)), 1.0, cosine)
	if factor <= 0.0 or not clear_path(light.global_position, point):
		return 0.0
	var attenuation := light.get_param(Light3D.PARAM_ATTENUATION)
	return factor * light.light_energy * light.light_color.get_luminance() / pow(maxf(1.0, distance), attenuation)

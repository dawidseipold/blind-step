extends OmniLight3D

@export_range(1, 20) var matches := 5
@export_range(1.0, 30.0) var burn_seconds := 5.0
var unlimited := false
var flicker_amplitude := 0.035
var flicker_period := 2.8
var flame_tail := 10.0:
	set(value):
		flame_tail = value
		update_falloff()
var flame_radius := 2.5:
	set(value):
		flame_radius = value
		update_falloff()
var flame_power := 1.0
var flame_time := 0.0
var burn_left := 0.0

# At core + tail the direct illuminance is about 1/16 of that at the core.
func update_falloff() -> void:
	omni_attenuation = clampf(log(16.0) / log(1.0 + flame_tail / flame_radius), 0.5, 4.0)
	omni_range = flame_radius + 3.0 * flame_tail

func _ready() -> void:
	update_falloff()
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("light_match"):
		return
	if burn_left > 0.0:
		burn_left = 0.0
		hide()
	elif matches > 0 or unlimited:
		if not unlimited:
			matches -= 1
		burn_left = burn_seconds
		show()

func _physics_process(delta: float) -> void:
	if burn_left <= 0.0:
		return
	flame_time += delta
	var phase := TAU * flame_time / flicker_period
	var flicker := 0.8 * sin(phase) + 0.2 * sin(phase * 0.63)
	light_energy = flame_power * pow(flame_radius, omni_attenuation) / 6.25 * (1.0 + flicker_amplitude * flicker)
	if not unlimited:
		burn_left = maxf(0.0, burn_left - delta)
		visible = burn_left > 0.0

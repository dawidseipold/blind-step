extends SpotLight3D

@export_range(0.1, 5.0, 0.1) var hold_seconds := 1.0
@export_range(0.1, 5.0, 0.1) var fade_seconds := 1.0

@onready var peak_energy := light_energy
var remaining := 0.0

func _ready() -> void:
	hide()
	set_process(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight") and remaining <= 0.0:
		remaining = hold_seconds + fade_seconds
		light_energy = peak_energy
		show()
		set_process(true)

func _process(delta: float) -> void:
	remaining = maxf(0.0, remaining - delta)
	light_energy = peak_energy * smoothstep(0.0, fade_seconds, remaining)
	if remaining <= 0.0:
		hide()
		set_process(false)

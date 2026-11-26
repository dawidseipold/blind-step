extends SpotLight3D

@export_range(1, 20) var matches := 5
@export_range(1.0, 30.0) var burn_seconds := 5.0
@export_range(1.0, 120.0) var cell_seconds := 25.0
@export_range(0, 10) var spare_cells := 2
@onready var charge := cell_seconds
@onready var beam_energy := light_energy
@onready var flame: OmniLight3D = $Match
var unlimited := false
var flicker_amplitude := 0.035
var flicker_period := 2.8
var flame_power := 1.0
var flame_time := 0.0
var burn_left := 0.0
var has_torch := false

func _ready() -> void:
	light_energy = 0.0
	flame.hide()

func select_torch(selected: bool) -> void:
	if selected == has_torch:
		return
	burn_left = 0.0
	flame.hide()
	light_energy = 0.0
	has_torch = selected

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight"):
		if has_torch:
			light_energy = beam_energy if light_energy == 0.0 and (charge > 0.0 or unlimited) else 0.0
		elif burn_left > 0.0:
			burn_left = 0.0
			flame.hide()
		elif matches > 0 or unlimited:
			if not unlimited:
				matches -= 1
			burn_left = burn_seconds
			flame.show()
	elif event.is_action_pressed("replace_cell") and has_torch and not unlimited and spare_cells > 0 and charge < cell_seconds:
		spare_cells -= 1
		charge = cell_seconds

func _physics_process(delta: float) -> void:
	if burn_left > 0.0:
		flame_time += delta
		var phase := TAU * flame_time / flicker_period
		flame.light_energy = flame_power * (1.0 + flicker_amplitude * (0.8 * sin(phase) + 0.2 * sin(phase * 0.63)))
		if not unlimited:
			burn_left = maxf(0.0, burn_left - delta)
		flame.visible = burn_left > 0.0
	elif light_energy > 0.0 and not unlimited:
		charge = maxf(0.0, charge - delta)
		if charge <= 0.0:
			light_energy = 0.0

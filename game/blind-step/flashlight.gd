extends SpotLight3D

@export_range(1, 20) var matches := 5
@export_range(1.0, 30.0) var burn_seconds := 7.0
@export_range(1.0, 120.0) var cell_seconds := 25.0
@export_range(0, 10) var spare_cells := 2
@onready var charge := cell_seconds
@onready var flame: OmniLight3D = $Match
var burn_left := 0.0
var has_torch := false

func _ready() -> void:
	light_energy = 0.0
	flame.hide()

func equip_torch() -> void:
	if not has_torch:
		burn_left = 0.0
		flame.hide()
		has_torch = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight"):
		if has_torch:
			light_energy = 4.0 if light_energy == 0.0 and charge > 0.0 else 0.0
		elif burn_left > 0.0:
			burn_left = 0.0
			flame.hide()
		elif matches > 0:
			matches -= 1
			burn_left = burn_seconds
			flame.show()
	elif event.is_action_pressed("replace_cell") and has_torch and spare_cells > 0 and charge < cell_seconds:
		spare_cells -= 1
		charge = cell_seconds

func _physics_process(delta: float) -> void:
	if burn_left > 0.0:
		burn_left = maxf(0.0, burn_left - delta)
		flame.visible = burn_left > 0.0
	elif light_energy > 0.0:
		charge = maxf(0.0, charge - delta)
		if charge <= 0.0:
			light_energy = 0.0

extends CharacterBody3D

@export_range(0.5, 8.0, 0.1) var walk_speed := 3.0
@export_range(0.01, 1.0, 0.01) var degrees_per_pixel := 0.12
@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.screen_relative.x * degrees_per_pixel))
		camera.rotation_degrees.x = clampf(camera.rotation_degrees.x - event.screen_relative.y * degrees_per_pixel, -85.0, 85.0)

func _physics_process(delta: float) -> void:
	var axes := Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_back")
	var direction := transform.basis * Vector3(axes.x, 0.0, axes.y)
	velocity.x = direction.x * walk_speed
	velocity.z = direction.z * walk_speed
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

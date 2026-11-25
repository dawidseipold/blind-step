extends CharacterBody3D

@export_range(0.5, 8.0, 0.1) var walk_speed := 3.0
@export_range(0.3, 3.0, 0.1) var crouch_speed := 1.5
@export_range(0.01, 1.0, 0.01) var degrees_per_pixel := 0.12
@onready var camera: Camera3D = $Camera3D
@onready var collider: CollisionShape3D = $Collider
@onready var capsule: CapsuleShape3D = collider.shape
@onready var standing_height := capsule.height
@onready var standing_eye_height := camera.position.y

const CROUCH_HEIGHT := 1.0
var crouching := false
var headroom := PhysicsShapeQueryParameters3D.new()

func _ready() -> void:
	# Volume swept by the top hemisphere when rising. The floor stays outside it.
	var clearance := CapsuleShape3D.new()
	clearance.radius = capsule.radius
	clearance.height = standing_height - CROUCH_HEIGHT + 2.0 * capsule.radius
	headroom.shape = clearance
	headroom.exclude = [get_rid()]
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
	update_stance()
	var axes := Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_back")
	var direction := transform.basis * Vector3(axes.x, 0.0, axes.y)
	var speed := crouch_speed if crouching else walk_speed
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func update_stance() -> void:
	var wants_crouch := Input.is_action_pressed("crouch")
	if wants_crouch == crouching:
		return
	if not wants_crouch:
		var clearance_center := (standing_height + CROUCH_HEIGHT) * 0.5 - capsule.radius
		headroom.transform = global_transform.translated_local(Vector3.UP * clearance_center)
		headroom.collision_mask = collision_mask
		if not get_world_3d().direct_space_state.intersect_shape(headroom, 1).is_empty():
			return
	crouching = wants_crouch
	capsule.height = CROUCH_HEIGHT if crouching else standing_height
	collider.position.y = capsule.height * 0.5
	camera.position.y = standing_eye_height - (standing_height - capsule.height)

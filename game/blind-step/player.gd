extends CharacterBody3D

@export_range(0.5, 8.0, 0.1) var walk_speed := 3.0
@export_range(0.3, 3.0, 0.1) var crouch_speed := 1.5
@export_range(1.0, 80.0, 0.5) var acceleration := 20.0
@export_range(1.0, 80.0, 0.5) var braking := 30.0
@export_range(0.01, 1.0, 0.01) var degrees_per_pixel := 0.12
@export_group("Sprint")
@export_range(3.0, 12.0, 0.1) var sprint_speed := 8.0
@export_range(0.5, 15.0, 0.1) var sprint_seconds := 6.0
@export_range(0.0, 5.0, 0.05) var recovery_delay := 1.25
@export_range(0.5, 12.0, 0.1) var recovery_seconds := 4.0
@export_group("Slide")
@export_range(0.2, 1.2, 0.05) var slide_seconds := 0.65
@onready var camera: Camera3D = $Camera3D
@onready var collider: CollisionShape3D = $Collider
@onready var capsule: CapsuleShape3D = collider.shape
@onready var standing_height := capsule.height
@onready var standing_eye_height := camera.position.y

const CROUCH_HEIGHT := 1.0
const RESERVE := 0.20
const SLIDE_COST := 0.08
var reserve_wait := false
var ran_last_tick := false
var slide_left := 0.0
var slide_velocity := Vector2.ZERO
var crouching := false
var stamina := 1.0
var recovery_wait := 0.0
var exhausted := false
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
	var horizontal := Vector2(velocity.x, velocity.z)
	if not crouching and Input.is_action_pressed("crouch") and ran_last_tick and is_on_floor() and horizontal.length() >= sprint_speed * 0.75 and stamina >= SLIDE_COST:
		slide_left = slide_seconds
		slide_velocity = horizontal
		spend_stamina(SLIDE_COST)
	var sliding := slide_left > 0.0
	update_stance(sliding or Input.is_action_pressed("crouch"))
	var axes := Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_back")
	var direction := transform.basis * Vector3(axes.x, 0.0, axes.y)
	var speed := crouch_speed if crouching else walk_speed
	var wants_sprint := Input.is_action_pressed("sprint")
	if exhausted and not wants_sprint and stamina >= 0.25:
		exhausted = false
	var sprinting := wants_sprint and not exhausted and not crouching and is_on_floor() and axes != Vector2.ZERO
	if sprinting:
		speed = sprint_speed
	var target := Vector2(direction.x, direction.z) * speed
	if sliding:
		horizontal = slide_velocity.normalized() * lerpf(crouch_speed, slide_velocity.length(), slide_left / slide_seconds)
	else:
		var slowing := horizontal.length_squared() > target.length_squared() or horizontal.dot(target) < 0.0
		horizontal = horizontal.move_toward(target, (braking if slowing else acceleration) * delta)
	velocity.x = horizontal.x
	velocity.z = horizontal.y
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	var travel := get_position_delta()
	ran_last_tick = sprinting and Vector2(travel.x, travel.z).length() > 0.0001
	if sliding:
		slide_left = 0.0 if is_on_wall() or not is_on_floor() else maxf(0.0, slide_left - delta)
	elif ran_last_tick:
		var budget := delta / sprint_seconds
		var above_reserve := minf(budget, maxf(0.0, stamina - RESERVE))
		spend_stamina(above_reserve + (budget - above_reserve) * 0.5)
	elif recovery_wait > 0.0:
		recovery_wait = maxf(0.0, recovery_wait - delta)
		if is_zero_approx(recovery_wait):
			recovery_wait = 0.0
			reserve_wait = false
	else:
		stamina = minf(1.0, stamina + delta / recovery_seconds)

func spend_stamina(amount: float) -> void:
	stamina = maxf(0.0, stamina - amount)
	reserve_wait = stamina <= RESERVE or is_equal_approx(stamina, RESERVE)
	exhausted = is_zero_approx(stamina)
	recovery_wait = recovery_delay * (2.0 if reserve_wait else 1.0)

func update_stance(wants_crouch: bool) -> void:
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

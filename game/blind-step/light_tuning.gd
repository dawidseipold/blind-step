extends PanelContainer

@onready var course = get_parent().get_parent()
var rows := VBoxContainer.new()
var initialized := false

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_F4 and event.pressed and not event.echo:
		if not initialized:
			build_panel()
		visible = not visible
		course.player.set_process_unhandled_input(not visible)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED
		get_viewport().set_input_as_handled()

func build_panel() -> void:
	initialized = true
	set_anchors_and_offsets_preset(Control.PRESET_RIGHT_WIDE)
	offset_left = -395
	var scroll := ScrollContainer.new()
	add_child(scroll)
	scroll.add_child(rows)
	var toggle := CheckButton.new()
	toggle.text = "Nieskończone zasoby"
	rows.add_child(toggle)
	toggle.toggled.connect(set_unlimited)
	var lamp = course.lamp
	slider("Zapałka · zasięg (m)", lamp.flame, "omni_range", 0.5, 5, 0.1)
	slider("Moc płomienia", lamp, "flame_power", 0.1, 2, 0.05)
	slider("Wahanie jasności", lamp, "flicker_amplitude", 0, 0.15, 0.005)
	slider("Okres wahania (s)", lamp, "flicker_period", 1, 8, 0.1)
	slider("Czas palenia (s)", lamp, "burn_seconds", 1, 30, 0.5)
	slider("Latarka · zasięg (m)", lamp, "spot_range", 2, 28, 0.5)
	slider("Moc latarki", lamp, "beam_energy", 0.1, 5, 0.1)
	slider("Półkąt wiązki (°)", lamp, "spot_angle", 8, 50, 0.1)
	slider("Wygaszenie brzegu", lamp, "spot_angle_attenuation", 0.1, 3, 0.05)
	slider("Czas pełnej ekspozycji (s)", course, "full_exposure", 0.25, 6, 0.25)
	slider("Ślad zapałki (s)", course, "match_trace_seconds", 1, 20, 0.5)
	slider("Ślad latarki (s)", course, "torch_trace_seconds", 1, 30, 0.5)
	slider("Punkty na metr", course, "dots_per_metre", 3, 14, 0.5)

func slider(title: String, target: Object, property: String, low: float, high: float, step_size: float) -> void:
	var row := HBoxContainer.new()
	rows.add_child(row)
	var label := Label.new()
	label.custom_minimum_size.x = 216
	row.add_child(label)
	var bar := HSlider.new()
	bar.custom_minimum_size.x = 140
	bar.min_value = low
	bar.max_value = high
	bar.step = step_size
	bar.value = target.get(property)
	row.add_child(bar)
	label.text = "%s  %s" % [title, bar.value]
	bar.value_changed.connect(func(value: float):
		target.set(property, value)
		label.text = "%s  %s" % [title, value]
		if property == "beam_energy" and course.lamp.light_energy > 0.0:
			course.lamp.light_energy = value
		course.material.set_shader_parameter("trace_limits", Vector2(course.match_trace_seconds, course.torch_trace_seconds))
	)

func set_unlimited(enabled: bool) -> void:
	course.lamp.unlimited = enabled
	course.player.unlimited_stamina = enabled
	if enabled:
		course.player.stamina = 1.0
		course.player.exhausted = false
		course.player.reserve_wait = false
		course.player.recovery_wait = 0.0

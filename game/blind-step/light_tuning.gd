extends PanelContainer

@onready var course = get_parent().get_parent()
var rows := VBoxContainer.new()
static var settings := {}
var overlay := ColorRect.new()
var psx := ColorRect.new()
var retro := ShaderMaterial.new()
var optics := ShaderMaterial.new()
var body_fov := 92.0:
	set(value):
		body_fov = value
		if overlay.visible:
			course.camera.fov = value
var darkness := 100.0:
	set(value):
		darkness = value
		var env: Environment = course.get_node("Environment").environment
		env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
		env.ambient_light_energy = (100.0 - value) / 100.0
var normal_fov := 75.0

func initialize() -> void:
	normal_fov = course.camera.fov
	var env: Environment = course.get_node("Environment").environment
	if env.ambient_light_source == Environment.AMBIENT_SOURCE_COLOR:
		darkness = 100.0 * (1.0 - env.ambient_light_energy)
	else:
		env.ambient_light_color = Color(0.55, 0.58, 0.64)
		darkness = 100.0
	var layer := CanvasLayer.new()
	layer.layer = 0
	course.add_child(layer)
	layer.add_child(psx)
	psx.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	psx.mouse_filter = Control.MOUSE_FILTER_IGNORE
	retro.shader = preload("res://addons/psx_shader/shaders/psx_screen.gdshader")
	retro.set_shader_parameter("screen_amount", 0.42)
	retro.set_shader_parameter("screen_pixel_size", 2.0)
	retro.set_shader_parameter("screen_dither", 1.0)
	psx.material = retro
	var copy := BackBufferCopy.new()
	copy.copy_mode = BackBufferCopy.COPY_MODE_VIEWPORT
	layer.add_child(copy)
	layer.add_child(overlay)
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	optics.shader = preload("res://bodycam.gdshader")
	optics.set_shader_parameter("distortion", 0.22)
	optics.set_shader_parameter("vignette", 0.32)
	optics.set_shader_parameter("noise_amount", 0.12)
	optics.set_shader_parameter("frame_size", 1.0)
	optics.set_shader_parameter("frame_feather", 0.04)
	optics.set_shader_parameter("edge_blur", 0.0)
	optics.set_shader_parameter("blur_start", 0.60)
	optics.set_shader_parameter("aberration", 1.5)
	optics.set_shader_parameter("grain_rate", 20.0)
	overlay.material = optics
	build_panel()


func section(title: String) -> void:
	rows.add_child(HSeparator.new())
	var label := Label.new()
	label.text = title
	rows.add_child(label)

func set_bodycam(enabled: bool) -> void:
	settings["bodycam"] = enabled
	overlay.visible = enabled
	psx.visible = enabled
	course.camera.fov = body_fov if enabled else normal_fov

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_F4 and event.pressed and not event.echo:
		visible = not visible
		course.player.set_process_unhandled_input(not visible)
		course.lamp.set_process_unhandled_input(not visible)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED
		get_viewport().set_input_as_handled()

func build_panel() -> void:
	section("Testy")
	set_anchors_and_offsets_preset(Control.PRESET_RIGHT_WIDE)
	offset_left = -440
	var scroll := ScrollContainer.new()
	add_child(scroll)
	scroll.add_child(rows)
	var toggle := CheckButton.new()
	toggle.text = "Nieskończone zasoby"
	rows.add_child(toggle)
	toggle.button_pressed = settings.get("unlimited", true)
	set_unlimited(toggle.button_pressed)
	toggle.toggled.connect(set_unlimited)
	var map := OptionButton.new()
	map.add_item("Mapa · Korytarz")
	map.add_item("Mapa · Sala pałacu")
	rows.add_child(map)
	map.select(1 if course.scene_file_path == "res://bench.tscn" else 0)
	map.item_selected.connect(func(index: int):
		get_tree().change_scene_to_file("res://bench.tscn" if index == 1 else "res://light_course.tscn")
	)
	section("Otoczenie")
	slider("Ciemność otoczenia (%)", self, "darkness", 0, 100, 0.1)
	section("Zapałka")
	var lamp = course.lamp
	slider("Promień jasny (m)", lamp, "flame_radius", 0.5, 5, 0.1)
	color_picker("Kolor płomienia", lamp, "light_color", "match_color")
	slider("Zanik poza rdzeniem (m)", lamp, "flame_tail", 0.5, 24, 0.5)
	slider("Moc płomienia", lamp, "flame_power", 0.1, 2, 0.05)
	slider("Wahanie jasności", lamp, "flicker_amplitude", 0, 0.15, 0.005)
	slider("Okres wahania (s)", lamp, "flicker_period", 1, 8, 0.1)
	slider("Czas palenia (s)", lamp, "burn_seconds", 1, 30, 0.5)
	section("Optyka bodycam")
	var body := CheckButton.new()
	body.text = "Włącz bodycam"
	rows.add_child(body)
	body.button_pressed = settings.get("bodycam", true)
	set_bodycam(body.button_pressed)
	body.toggled.connect(set_bodycam)
	slider("Pole widzenia (°)", self, "body_fov", 65, 115, 1)
	slider("Dystorsja", optics, "shader_parameter/distortion", 0, 0.65, 0.01)
	slider("Rozmiar ramki", optics, "shader_parameter/frame_size", 0.72, 1, 0.01)
	slider("Miękkość ramki", optics, "shader_parameter/frame_feather", 0.005, 0.20, 0.005)
	slider("Rozmycie brzegu (px)", optics, "shader_parameter/edge_blur", 0, 16, 0.5)
	slider("Początek rozmycia", optics, "shader_parameter/blur_start", 0.15, 0.95, 0.01)
	slider("Aberracja (px)", optics, "shader_parameter/aberration", 0, 6, 0.1)
	slider("Tempo ziarna (Hz)", optics, "shader_parameter/grain_rate", 1, 60, 1)
	slider("Winieta", optics, "shader_parameter/vignette", 0, 0.9, 0.01)
	slider("Szum w cieniu", optics, "shader_parameter/noise_amount", 0, 1, 0.01)
	section("PSX")
	slider("Siła efektu PSX", retro, "shader_parameter/screen_amount", 0, 1, 0.01)
	slider("Rozmiar piksela PSX", retro, "shader_parameter/screen_pixel_size", 1, 5, 0.5)
	slider("Siła ditheringu", retro, "shader_parameter/screen_dither", 0, 1, 0.05)

func color_picker(title: String, target: Object, property: String, key: String) -> void:
	var row := HBoxContainer.new()
	rows.add_child(row)
	var label := Label.new()
	label.text = title
	label.custom_minimum_size.x = 216
	row.add_child(label)
	var picker := ColorPickerButton.new()
	picker.custom_minimum_size.x = 140
	picker.edit_alpha = false
	picker.color = settings.get(key, target.get(property))
	target.set(property, picker.color)
	row.add_child(picker)
	picker.color_changed.connect(func(value: Color):
		settings[key] = value
		target.set(property, value)
	)

func slider(title: String, target: Object, property: String, low: float, high: float, step_size: float) -> void:
	var row := HBoxContainer.new()
	rows.add_child(row)
	var label := Label.new()
	label.custom_minimum_size.x = 216
	row.add_child(label)
	var bar := HSlider.new()
	bar.custom_minimum_size.x = 100
	bar.min_value = low
	bar.max_value = high
	bar.step = minf(step_size, 0.001)
	bar.value = settings.get(property, target.get(property))
	target.set(property, bar.value)
	row.add_child(bar)
	label.text = title
	var number := SpinBox.new()
	number.custom_minimum_size.x = 84
	number.custom_arrow_step = step_size
	row.add_child(number)
	bar.share(number)
	bar.value_changed.connect(func(value: float):
		settings[property] = value
		target.set(property, value)
	)

func set_unlimited(enabled: bool) -> void:
	settings["unlimited"] = enabled
	course.lamp.unlimited = enabled
	course.player.unlimited_stamina = enabled
	if enabled:
		course.player.stamina = 1.0
		course.player.exhausted = false
		course.player.reserve_wait = false
		course.player.recovery_wait = 0.0

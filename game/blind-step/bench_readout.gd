extends Label

const Flashlight = preload("res://flashlight.gd")
const Player = preload("res://player.gd")
@export var player: Player
@onready var lamp := player.get_node("Camera3D/Flashlight") as Flashlight

func _process(_delta: float) -> void:
	if visible:
		var lines := PackedStringArray(["Stamina %d/100" % roundi(player.stamina * 100.0)])
		if player.slide_left > 0.0:
			lines.append("Ślizg")
		if player.reserve_wait:
			lines.append("Rezerwa · dłuższy odpoczynek")
		if lamp.has_torch:
			lines.append("Latarka %d%% · zapas %d · F światło / R bateria" % [ceili(100.0 * lamp.charge / lamp.cell_seconds), lamp.spare_cells])
		else:
			lines.append("Zapałki %d · F zapal / zgaś" % lamp.matches)
			if lamp.burn_left > 0.0 and not lamp.unlimited:
				lines.append("Płomień %.1f s" % lamp.burn_left)
		if get_parent().has_node("Tuning"):
			lines.append("F4 · strojenie światła" + (" · zasoby ∞" if lamp.unlimited else ""))
		text = "\n".join(lines)

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_F3 and event.pressed and not event.echo:
		visible = not visible
		get_viewport().set_input_as_handled()

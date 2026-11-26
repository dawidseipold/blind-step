extends Label

const Player = preload("res://player.gd")
@export var player: Player

func _process(_delta: float) -> void:
	if visible:
		var lines := PackedStringArray(["Stamina %d/100" % roundi(player.stamina * 100.0)])
		if player.slide_left > 0.0:
			lines.append("Ślizg")
		if player.reserve_wait:
			lines.append("Rezerwa · dłuższy odpoczynek")
		text = "\n".join(lines)

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_F3 and event.pressed and not event.echo:
		visible = not visible
		get_viewport().set_input_as_handled()

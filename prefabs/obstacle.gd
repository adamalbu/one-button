extends Area2D
var center_pos: Vector2
var start_pos: Vector2
var t: float = 0

func _ready():
	get_tree().root.connect("size_changed", _on_window_size_changed)
	_on_window_size_changed()
	start_pos = position

func _process(delta):
	t += delta * 0.5
	t = clamp(t, 0, 1)
	position = start_pos.lerp(center_pos, t)
	# position = clamp(position, abs(start_pos), center_pos)

func _on_window_size_changed() -> void:
	center_pos = get_viewport_rect().size / 2

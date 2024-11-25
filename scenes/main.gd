extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.connect("size_changed", _on_window_size_changed)
	_on_window_size_changed()

func _on_window_size_changed() -> void:
	# Center dome
	var screen_size = get_viewport_rect().size
	var dome = $Dome
	dome.position = screen_size / 2

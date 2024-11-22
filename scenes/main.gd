extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Center dome
	var screen_size = get_viewport_rect().size
	var dome = $Dome
	dome.position = screen_size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
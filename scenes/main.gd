# You just lost the game
# :3
extends Node2D

func _ready() -> void:
	# Center dome
	var screen_size = get_viewport_rect().size
	var dome = $Dome
	dome.position = screen_size / 2

# You just lost the game
# :3
extends Node2D
var fields: Array[Sprite2D] = []
var timer: Timer

func _ready() -> void:
	# Center dome
	var screen_size = get_viewport_rect().size
	var dome = $Dome
	dome.position = screen_size / 2
	# Create timer
	timer = Timer.new()
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	new_timer()

func new_timer() -> void:
	timer.wait_time = randf_range(1, 3)
	timer.start()

func _on_timer_timeout() -> void:
	# Create field
	var field = preload("res://prefabs/field.tscn").instantiate()
	fields.append(field)
	add_child(field)
	# Create new timer
	new_timer()

func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.is_action_pressed("button"):
			var field = fields.pop_front()
			if field:
				field.queue_free()

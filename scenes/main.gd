# You just lost the game
# :3
extends Node2D
var fields: Array[Sprite2D] = []
var timer: Timer
const hit_tolerance: float = 500

func _ready() -> void:
	get_tree().root.connect("size_changed", _on_window_size_changed)
	_on_window_size_changed()
	# Create timer
	timer = Timer.new()
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	new_timer()

func _on_window_size_changed() -> void:
	# Center dome
	var screen_size = get_viewport_rect().size
	var dome = $Dome
	dome.position = screen_size / 2

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
			hit_field()

func hit_field():
	if len(fields) > 0:
		var field = fields[0]
		if field:
			var time_offset = 0.0
			if field.shrink_timer.is_stopped():
				time_offset = abs(field.pass_time - Time.get_ticks_msec())
			else:
				time_offset = field.shrink_timer.time_left * 1000
			time_offset -= 20

			if field.shrink_timer.is_stopped():
				if abs(field.pass_time - Time.get_ticks_msec()) >= hit_tolerance:
					fields.pop_front()
					field.queue_free()
					hit_field()

			if time_offset <= hit_tolerance:
				var score = remap(time_offset, 0, hit_tolerance, 100, 0)
				print("Score: ", score)
				show_score(score)
				fields.pop_front()
				field.queue_free()

func show_score(score):
	score = roundf(score/10) * 10
	var score_label = preload("res://prefabs/score_label.tscn").instantiate()
	# Text
	var text_score: String
	if score >= 95:
		text_score = "Perfect!"
	elif score >= 80:
		text_score = "Great"
	elif score >= 60:
		text_score = "Good"
	elif score >= 30:
		text_score = "Ok"
	else:
		text_score = "Bad"
	score_label.text = str(text_score)
	# Center score label
	var screen_size = get_viewport_rect().size
	score_label.position = screen_size / 2 - Vector2(305, 62) / 2
	score_label.position.y -= 100
	add_child(score_label)

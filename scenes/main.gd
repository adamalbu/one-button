extends Node2D
const radius = 1000
var center_pos = Vector2()
var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.connect("size_changed", _on_window_size_changed)
	_on_window_size_changed()
	spawn_obstacle()

	timer = Timer.new()
	timer.set_wait_time(randf_range(1, 3))
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	spawn_obstacle()
	restart_timer()

func restart_timer():
	timer.set_wait_time(randf_range(1, 3))
	timer.start()

func spawn_obstacle():
	var obstacle = preload("res://prefabs/obstacle.tscn").instantiate()
	var angle = randf_range(0, 2 * PI)
	obstacle.position = Vector2(cos(angle), sin(angle)) * radius + center_pos
	add_child(obstacle)

func _on_window_size_changed() -> void:
	# Center dome
	center_pos = get_viewport_rect().size / 2
	var dome = $Dome
	dome.position = center_pos

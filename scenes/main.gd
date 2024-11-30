extends Node2D
const radius = 1000
var center_pos = Vector2()
var bug_timer: Timer
var health_timer: Timer
var health = 100

var bug_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	get_tree().root.connect("size_changed", _on_window_size_changed)
	_on_window_size_changed()
	spawn_obstacle()

	bug_timer = Timer.new()
	bug_timer.set_wait_time(randf_range(1, 3))
	bug_timer.connect("timeout", _on_bug_timer_timeout)
	bug_timer.one_shot = true
	add_child(bug_timer)
	bug_timer.start()

	health_timer = Timer.new()
	health_timer.set_wait_time(3)
	health_timer.connect("timeout", _on_health_timer_timeout)
	health_timer.one_shot = false
	add_child(health_timer)
	health_timer.start()

func _on_bug_timer_timeout():
	spawn_obstacle()
	restart_timer()

func _on_health_timer_timeout():
	update_health(5)

func update_health(value: int):
	health += value
	health = clamp(health, 0, 100)
	$"../HealthBar".value = health
	if health <= 0:
		get_tree().reload_current_scene() # TODO: replace with game over screen

func restart_timer():
	bug_timer.set_wait_time(randf_range(1, 3))
	bug_timer.start()

func spawn_obstacle():
	var obstacle = preload("res://prefabs/obstacle.tscn").instantiate()
	var angle = randf_range(0, 2 * PI)
	obstacle.position = Vector2(cos(angle), sin(angle)) * radius + center_pos
	add_child(obstacle)
	obstacle.connect("dome_hit", dome_hit)
	obstacle.connect("blocked", bug_blocked)

func dome_hit():
	update_health(-10)

func bug_blocked():
	bug_counter += 1
	print(bug_counter)
	Engine.time_scale = 1.0 + bug_counter / 50.0

func _on_window_size_changed() -> void:
	# Center dome
	center_pos = get_viewport_rect().size / 2
	var dome = $Dome
	dome.position = center_pos

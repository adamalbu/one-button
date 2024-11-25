extends Node2D
var blocker_size = GlobalVariables.blocker_size
var rotation_speed = GlobalVariables.rotation_speed
var rot_dir: float = 1
var rotating = false

func _ready():
	get_tree().root.connect("size_changed", _on_window_size_changed)
	_on_window_size_changed()

	$BlockerTexture.value = blocker_size
	$RightArea.rotation_degrees = remap(blocker_size, 0, 100, 0, 360)
	rotation_degrees = remap(blocker_size, 0, 100, 0, -180)

func _process(delta):
	if rotating:
		rotation_degrees += rotation_speed * delta * rot_dir

func _on_window_size_changed():
	var screen_size = get_viewport_rect().size
	position = screen_size / 2

func _input(event):
	if event.is_action_pressed("button"):
		rotating = true
	elif event.is_action_released("button"):
		rotating = false
		rot_dir *= -1

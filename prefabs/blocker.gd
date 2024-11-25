extends Node2D
var blocker_size = GlobalVariables.blocker_size
var rotation_speed = GlobalVariables.rotation_speed
var rot_dir: float = 1
var rotating = false

var overlaps = {
	"LeftArea": false,
	"RightArea": false,
	"CircleArea": false
}

func _ready():
	get_tree().root.connect("size_changed", _on_window_size_changed)
	_on_window_size_changed()

	$BlockerTexture.value = blocker_size
	$RightArea.rotation_degrees = remap(blocker_size, 0, 100, 0, 360)
	rotation_degrees = remap(blocker_size, 0, 100, 0, -180)

	$LeftArea.connect("area_entered", _on_area_entered.bind("LeftArea"))
	$LeftArea.connect("area_exited", _on_area_exited.bind("LeftArea"))
	$RightArea.connect("area_entered", _on_area_entered.bind("RightArea"))
	$RightArea.connect("area_exited", _on_area_exited.bind("RightArea"))
	$CircleArea.connect("area_entered", _on_area_entered.bind("CircleArea"))
	$CircleArea.connect("area_exited", _on_area_exited.bind("CircleArea"))

func _process(delta):
	if rotating:
		rotation_degrees += rotation_speed * delta * rot_dir

func _on_area_entered(body: Node, collider_name: String):
	if body.is_in_group("Obstacle"):
		overlaps[collider_name] = true
		check_all_colliders()
		print(overlaps)

func _on_area_exited(body: Node, collider_name: String):
	if body.is_in_group("Obstacle"):
		overlaps[collider_name] = false
		print(overlaps)

func check_all_colliders():
	if overlaps.values().all(func(x): return x):
		print("Object is touching all colliders!")

func _on_window_size_changed() -> void:
	# Center dome
	var screen_size = get_viewport_rect().size
	position = screen_size / 2

func _input(event):
	if event.is_action_pressed("button"):
		rotating = true
	elif event.is_action_released("button"):
		rotating = false
		rot_dir *= -1

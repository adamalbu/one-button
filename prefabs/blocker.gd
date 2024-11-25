extends Node2D
@export_range(0, 100) var blocker_size: int = 25
# False for counterclockwise true for clockwise
var next_move_dir = false

var overlaps = {
	"LeftArea": false,
	"RightArea": false,
	"CircleArea": false
}

func _ready():
	$BlockerTexture.value = blocker_size
	$RightArea.rotation_degrees = remap(blocker_size, 0, 100, 0, 360)
	rotation_degrees = remap(blocker_size, 0, 100, 0, -180)

	$LeftArea.connect("area_entered", _on_area_entered.bind("LeftArea"))
	$LeftArea.connect("area_exited", _on_area_exited.bind("LeftArea"))
	$RightArea.connect("area_entered", _on_area_entered.bind("RightArea"))
	$RightArea.connect("area_exited", _on_area_exited.bind("RightArea"))
	$CircleArea.connect("area_entered", _on_area_entered.bind("CircleArea"))
	$CircleArea.connect("area_exited", _on_area_exited.bind("CircleArea"))

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

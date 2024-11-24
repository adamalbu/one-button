extends Area2D
@export_range(0, 100) var blocker_size: int = 25

func _process(delta):
	$BlockerTexture.value = blocker_size
	$RightCollider.rotation_degrees = remap(blocker_size, 0, 100, 0, 360)
	rotation_degrees = remap(blocker_size, 0, 100, 0, -180)

	print(get_overlapping_areas())

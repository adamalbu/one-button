extends Area2D
var center_pos: Vector2
var start_pos: Vector2
var moving = true
var t: float = 0

var entered_areas = {
	"LeftArea": false,
	"RightArea": false,
	"OuterCircleArea": false,
	"InnerCircleArea": false,
	"Dome": false
}

func _ready():
	get_tree().root.connect("size_changed", _on_window_size_changed)
	_on_window_size_changed()
	start_pos = position

func _process(delta):
	if moving:
		t += delta * 0.5
		t = clamp(t, 0, 1)
		position = start_pos.lerp(center_pos, t)

func _on_window_size_changed() -> void:
	center_pos = get_viewport_rect().size / 2

func _on_area_entered(area):
	entered_areas[area.name] = true
	check_areas()

func _on_area_exited(area):
	entered_areas[area.name] = false

func check_areas():
	# If only innercircle and outercircle entered, print miss and destroy object
	if entered_areas["InnerCircleArea"] and entered_areas["OuterCircleArea"] and !entered_areas["LeftArea"] and !entered_areas["RightArea"]:
		print("Miss")
	# If everything but innercircle is entered, print hit and destroy object
	elif entered_areas["LeftArea"] and entered_areas["RightArea"] and entered_areas["OuterCircleArea"] and !entered_areas["InnerCircleArea"]:
		print("Hit")
		moving = false
		$AnimatedSprite.play("explode")
		$AnimatedSprite.connect("animation_finished", _on_animation_finished)
	# If dome is entered, print dome hit and destroy object
	if entered_areas["Dome"]:
		print("Dome hit")
		moving = false
		$AnimatedSprite.play("explode")
		$AnimatedSprite.connect("animation_finished", _on_animation_finished)

func _on_animation_finished():
	print("ANIMATION FINISHED")
	queue_free()

extends Sprite2D
var shrink_timer: Timer
var reaction_time = GlobalVariables.reaction_time

func _ready() -> void:
	# Setup
	var screen_size = get_viewport_rect().size
	position = screen_size / 2
	scale = Vector2(3, 3)
	modulate = Color(1, 1, 1, 0)
	# Timer
	shrink_timer = Timer.new()
	shrink_timer.wait_time = reaction_time
	add_child(shrink_timer)
	shrink_timer.start()

func _process(_delta: float) -> void:
	# Shrink
	var scale_factor = remap(shrink_timer.time_left, 0, reaction_time, 0.56, 3)
	scale = Vector2(scale_factor, scale_factor)
	# Fade in
	modulate.a = remap(shrink_timer.time_left, reaction_time/1.7, reaction_time, 1, 0)
	modulate.a = clamp(modulate.a, 0, 1)
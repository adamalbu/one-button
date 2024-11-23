extends Label

func _ready():
	var position_tween = (get_tree().create_tween()
		.set_ease(Tween.EASE_OUT)
		.set_trans(Tween.TRANS_QUART))
	var alpha_tween = (get_tree().create_tween()
		.set_ease(Tween.EASE_OUT)
		.set_trans(Tween.TRANS_QUART))
	var target_pos = Vector2(0, -100) + position
	position_tween.tween_property(self, "position", target_pos, 2)
	alpha_tween.tween_property(self, "modulate", Color.TRANSPARENT, 2)
	alpha_tween.tween_callback(self.queue_free)

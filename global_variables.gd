extends Node
enum window_modes { WINDOWED, FULLSCREEN, BORDERLESS }
var long_press_threshold: int = 300
var window_mode = window_modes.WINDOWED
var blocker_size: int = 25
var rotation_speed: int = 300
var speed_increase_divisor: int = 50

func update_window_mode():
	match window_mode:
		window_modes.WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		window_modes.FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		window_modes.BORDERLESS:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)            

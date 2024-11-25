extends Node
enum window_modes { WINDOWED, FULLSCREEN, BORDERLESS }
var long_press_threshold: int = 300
var window_mode = window_modes.WINDOWED
var blocker_size: int = 25
var rotation_speed: int = 300

func update_window_mode():
	print("Window mode updated to: " + str(window_mode))
	match window_mode:
		window_modes.WINDOWED:
			print("Window mode set to: WINDOWED")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		window_modes.FULLSCREEN:
			print("Window mode set to: FULLSCREEN")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		window_modes.BORDERLESS:
			print("Window mode set to: BORDERLESS")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)            

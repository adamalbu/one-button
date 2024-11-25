extends Control
@export var settings: Dictionary = {
	"Window Mode": ["Windowed", "Fullscreen", "Borderless"],
	"Long Press Threshold": [200, 300, 500, 800],
	"Blocker Size": [10, 25, 30, 40, 60, 100],
	"Rotation Speed": [100, 200, 300, 400, 500]
}
var option_indexes: Dictionary = {} # Current values as an index
@onready var menu = $Menu
var menu_index: int = 0
var option_index: int = 0
var is_option: int = false
var press_start_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_current_values()
	update_menu()

func get_current_values():
	# Loop through settings dict and get the value from global variables
	var global_variable_name = ""
	var index = 0
	for item in settings.keys():
		global_variable_name = item.replace(" ", "_").to_lower()
		# If setting is string assume it is an enum and get the index
		if settings[item][0] is String:
			index = GlobalVariables.get(global_variable_name)
		else:
			index = settings[item].find(GlobalVariables.get(global_variable_name))
		if index == -1:
			option_indexes[item] = 0
		else:
			option_indexes[item] = index

func update_menu():
	var menu_text = ""
	# Wrap index
	menu_index = wrap(menu_index, 0, settings.size() + 1) # +1 for back option
	if menu_index < settings.size():
		option_index = wrap(option_index, 0, settings[settings.keys()[menu_index]].size())

	# Generate text
	for item in settings.keys():
		var displayed_item = item
		var displayed_option = str(settings[item][option_indexes[item]])

		if menu_index == settings.keys().find(item):
			if is_option:
				displayed_option = "> " + displayed_option + " <"
			else:
				displayed_item = "> " + item
		
		menu_text += displayed_item + ": " + displayed_option + "\n"
	
	# Add back option
	if menu_index == settings.size():
		menu_text += "> Back"
	else:
		menu_text += "Back"
	menu.text = menu_text

func update_variables():
	# Loop through settings dict and set the value to global variables
	var global_variable_name = ""

	for item in settings.keys():
		global_variable_name = item.replace(" ", "_").to_lower()
		# If first item is string, then assume the actual value is an enum and return the index
		if settings[item][0] is String:
			GlobalVariables.set(global_variable_name, option_indexes[item])
		else:
			GlobalVariables.set(global_variable_name, settings[item][option_indexes[item]])
		if global_variable_name == "window_mode":
			GlobalVariables.update_window_mode()

func _input(event):
	if event.is_action_pressed("button"):
		press_start_time = Time.get_ticks_msec()
	if event.is_action_released("button"):
		var duration = Time.get_ticks_msec() - press_start_time
		if duration > GlobalVariables.long_press_threshold:
			# Long press
			is_option = not is_option
			# If back
			if menu_index == settings.size():
				update_variables()
				get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
		else:
			# Short press
			if is_option:
				# If not back
				if menu_index != settings.size():
					# Change option
					var item = settings.keys()[menu_index]
					option_indexes[item] = wrap(option_indexes[item] + 1, 0, settings[item].size())
			else:
				menu_index += 1
		update_menu()

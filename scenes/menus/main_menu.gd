extends Control
@export var menu_items: PackedStringArray = ["Play", "Options", "Quit"]
@export var instructions: Dictionary = {
	"desktop": "Click or press space",
	"mobile": "Tap the screen",
	"web": "Click or press space if you're on a desktop,\nor tap the screen if you're on a mobile device."
}
@onready var menu = $Menu
var index = 0

# For checking how long user pressed button
var press_start_time = 0

func _ready():
	# Set up instructions
	for platform in instructions.keys():
		if OS.has_feature(platform):
			$Instructions.text = instructions[platform]
			break
	update_menu_text()

func _input(event):
	if event.is_action_pressed("button"):
		press_start_time = Time.get_ticks_msec()
	if event.is_action_released("button"):
		var duration = Time.get_ticks_msec() - press_start_time
		if duration > GlobalVariables.long_press_threshold:
			# Long press
			select()
		else:
			# Short press
			index += 1
			update_menu_text()

func update_menu_text():
	# Wrap index
	index = wrap(index, 0, menu_items.size())
	var menu_text = ""
	# Generate text
	for item in menu_items:
		if index == menu_items.find(item):
			menu_text += "> " + item + "\n"
		else:
			menu_text += item + "\n"
	# Remove last newline
	menu_text = menu_text.substr(0, menu_text.length() - 1)
	menu.text = menu_text

func select():
	match menu_items[index]:
		"Play":
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		"Options":
			get_tree().change_scene_to_file("res://scenes/menus/settings_menu.tscn")
		"Quit":
			get_tree().quit()
		_:
			print("Unknown option")

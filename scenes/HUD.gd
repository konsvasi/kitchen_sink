extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_key_input(event):
	if event.is_action_pressed('ui_open_menu'):
#		global.beforeMenuOpenPosition = global.Player.get_global_position()
#		print('beforeMenuOpenPos: ', global.beforeMenuOpenPosition)
		toggleMenu()

func toggleMenu():
	$Menu.visible = !$Menu.visible
	get_tree().set_pause($Menu.visible)		

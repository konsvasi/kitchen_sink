extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if global.previous_scene != null:
		if global.previous_scene == 'desk':
			$Player.set_position($respawn_from_desk_point.position)
		elif global.previous_scene == 'fridge':
			$Player.set_position($fridge_door.position)
		#if global.previous_scene == 'inventoryMenu':
			# put player in position before menu was opened
			# open menu

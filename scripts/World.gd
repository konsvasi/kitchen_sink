extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# Position player based on which scene the Player has come
	if global.previous_scene != null:
		if global.get_previous_scene() == "house_inside":
			var houseInsidePortalPosition = $HousePortal.get_global_position()
			$Player.set_position(houseInsidePortalPosition)

extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# Position player based on which scene the Player has come
	if global.previous_scene != null:
		if global.previous_scene == "House_inside":
			var houseInsidePortalPosition = get_node("Portal/CollisionShape2D").get_global_position()
			$Player.set_position(houseInsidePortalPosition)

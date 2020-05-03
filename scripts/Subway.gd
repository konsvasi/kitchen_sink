extends Node2D


onready var camera = $Camera
var shakeAmount = 0.1

func _process(delta):
	camera.set_offset(
		Vector2(rand_range(-1.0, 1.0),
		rand_range(-2.0, 3.0) * shakeAmount)
	)

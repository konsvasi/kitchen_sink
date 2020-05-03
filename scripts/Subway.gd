extends Node2D

onready var camera = $Camera
onready var tween = $Camera/CameraTween
var shakeAmount = 0.1
var reverse = false
var motion = 1
const SPEED = 50

func _ready():
	camera.get_node("AnimationPlayer").play("shake")
	
	
func _process(delta):
	motion -= 1
	$ParallaxBackground/Sky.set_motion_offset(Vector2(motion / 4, 0))
	$ParallaxBackground/Mountains.set_motion_offset(Vector2(motion / 2, 0))
	$ParallaxBackground/Skyline_front.set_motion_offset(Vector2(motion, 0))


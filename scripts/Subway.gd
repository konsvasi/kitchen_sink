extends Node2D

onready var camera = $Camera
onready var tween = $Camera/CameraTween
var shakeAmount = 0.1
var reverse = false
var motion = 1
const SPEED = 50

func _ready():
	tween.interpolate_property(camera, 'offset', Vector2(0, 0), Vector2(0, 3), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
func _process(delta):
	motion -= 1
	print('motion: ', motion, ' delta: ', delta)
	$ParallaxBackground/Sky.set_motion_offset(Vector2(motion / 4, 0))
	$ParallaxBackground/Mountains.set_motion_offset(Vector2(motion / 2, 0))
	$ParallaxBackground/Skyline_front.set_motion_offset(Vector2(motion, 0))


func _on_CameraTween_tween_completed(object, key):
	if reverse:
		tween.interpolate_property(camera, 'offset', Vector2(0, 0), Vector2(0, 3), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		reverse = false
	else:
		tween.interpolate_property(camera, 'offset', Vector2(0, 3), Vector2(0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		reverse = true

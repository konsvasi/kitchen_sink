extends Node2D

onready var camera = $Camera
onready var tween = $Camera/CameraTween
onready var cutinTween = $CutInTween
onready var cutin = $CutIn
var shakeAmount = 0.1
var reverse = false
var motion = 1
const SPEED = 50

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	camera.get_node("AnimationPlayer").play("shake")
	cutinTween.interpolate_property(cutin.get_material(), "shader_param/amount", 1.0, 0.0, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	cutinTween.start()
	
	
func _process(delta):
	motion -= 1
	$ParallaxBackground/Sky.set_motion_offset(Vector2(motion / 4, 0))
	$ParallaxBackground/Mountains.set_motion_offset(Vector2(motion / 2, 0))
	$ParallaxBackground/Skyline_front.set_motion_offset(Vector2(motion, 0))


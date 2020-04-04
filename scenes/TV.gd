extends Node

onready var Tween = get_node("TVMain/Tween")
var tweenPlayback = 'straight'

func _ready():
	Tween.interpolate_property($TVMain/Light2D, "texture_scale", 1, 2, 2, Tween.TRANS_SINE, Tween.EASE_IN)
	Tween.start()

func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_interact"):
		$Dialogbox.loadDialog()

func flicker_light():
	$TVMain/Light2D.texture_scale = smoothstep(1, 2, 0.15)

func _on_Tween_tween_all_completed():
	if tweenPlayback == 'straight':
		Tween.interpolate_property($TVMain/Light2D, "texture_scale", 2, 1, 2, Tween.TRANS_SINE, Tween.EASE_IN)
		Tween.start()
		tweenPlayback = 'reverse'
	else:
		Tween.interpolate_property($TVMain/Light2D, "texture_scale", 1, 2, 2, Tween.TRANS_SINE, Tween.EASE_IN)	
		Tween.start()
		tweenPlayback = 'straight'

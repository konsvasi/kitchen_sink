extends Node

onready var Tween = get_node("TVMain/Tween")
var tweenPlayback = 'straight'

func _ready():
	Tween.interpolate_property($TVMain/Light2D, "texture_scale", 1, 2, 2, Tween.TRANS_SINE, Tween.EASE_IN)
	Tween.start()
	$TVMain/Terry.modulate.a = 0
	$HUD.showDialog("tv", "main")

func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_interact"):
		$HUD/Dialogbox.loadDialog()

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


func _on_TerryTimer_timeout():
	$TVMain/Terry/Tween.interpolate_property($TVMain/Terry, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$TVMain/Terry/Tween.start()
	

func _on_Tween_tween_completed(object, key):
	if object is Light2D:
		if tweenPlayback == 'straight':
			Tween.interpolate_property($TVMain/Light2D, "texture_scale", 2, 1, 2, Tween.TRANS_SINE, Tween.EASE_IN)
			Tween.start()
			tweenPlayback = 'reverse'
		else:
			Tween.interpolate_property($TVMain/Light2D, "texture_scale", 1, 2, 2, Tween.TRANS_SINE, Tween.EASE_IN)	
			Tween.start()
			tweenPlayback = 'straight'
	else:
		$TVMain/Terry/Tween.stop(object, key)


func _on_HUD_dialogFinished(dialogId):
	print('ID', dialogId)
		# Check if you have to do anything after this dialog finishes
	if	dialogId == "main":
		print('Start a timer')
		$TVMain/TerryTimer.start()

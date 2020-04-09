extends Node

onready var Tween = get_node("TVMain/Tween")
var tweenPlayback = 'straight'
var SPEED = 100
var GRAVITY = 40
var VELOCITY = Vector2()
const FLOOR = Vector2(0, -1);
var hasSignal = false
var canMoveRemote = false
var lowerRemoteControl = false
var mainDialogFinished = false

func _ready():
	Tween.interpolate_property($TVMain/Light2D, "texture_scale", 1, 2, 2, Tween.TRANS_SINE, Tween.EASE_IN)
	Tween.start()
	$TVMain/Terry.modulate.a = 0
	$HUD.showDialog("tv", "main")
	# Disable menu in scene
	$HUD.disableMenu()
	$TVMain/Lofi.playing = false

#func _process(delta):
#	pass

func _physics_process(delta):
	if canMoveRemote:
		VELOCITY.y = randi() & GRAVITY
		if Input.is_action_pressed("ui_right"):
			VELOCITY.x = SPEED;
		elif Input.is_action_pressed("ui_left"):
			VELOCITY.x = -SPEED;
		elif Input.is_action_pressed("ui_up"):
			VELOCITY.y = -GRAVITY * 2;
	elif lowerRemoteControl:
		VELOCITY.y = GRAVITY			
	
	VELOCITY = $TVMain/TVRemote.move_and_slide(VELOCITY, FLOOR)
	
func _unhandled_key_input(event):
	if Input.is_action_just_pressed("ui_interact"):
		if hasSignal:
			$TVMain/TvContent.play("lofi-channel")
			$TVMain/TvContent.visible = !$TVMain/TvContent.visible
			$TVMain/Lofi.playing = !$TVMain/Lofi.playing
			canMoveRemote = false
			VELOCITY.x = 0
			yield(get_tree().create_timer(1.0), "timeout")
			lowerRemoteControl = true
#			$TVMain/TripTimer.start()
		
		if !mainDialogFinished:
			$HUD/Dialogbox.loadDialog()
			
func flicker_light():
	$TVMain/Light2D.texture_scale = smoothstep(1, 2, 0.15)

# TV Remote move code
func move(direction):
	if direction == "left":
		$TVMain/TVRemote.move_and_slide(Vector2(-VELOCITY,0),Vector2(10,0))
	elif direction == "right":
		$TVMain/TVRemote.move_and_slide(Vector2(VELOCITY,0),Vector2(10,0))		
	elif direction == "up":
		$TVMain/TVRemote.move_and_slide(Vector2(0,-VELOCITY),Vector2(10,0))	


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
		# Check if you have to do anything after this dialog finishes
	if	dialogId == "main":
		$HUD.showNotification("remote_minigame")
		$TVMain/TVRemote.show()
		mainDialogFinished = true
		
func _on_InfraredPoint_area_entered(area):
	hasSignal = true
	$TVMain/InfraredPoint/active.show()


func _on_InfraredPoint_area_exited(area):
	hasSignal = false
	$TVMain/InfraredPoint/active.hide()


func _on_HUD_notificationClosed():
	canMoveRemote = true


func _on_TripTimer_timeout():
	$TVMain/Lofi/pitchTween.interpolate_property($TVMain/Lofi, "pitch_scale", 1.0, 0.2, 10, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$TVMain/Lofi/pitchTween.start()


func _on_VisibilityNotifier2D_screen_exited():
	$HUD.showDialog("tv", "enoying_the_music")

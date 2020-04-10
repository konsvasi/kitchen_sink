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
var tripScene = preload("res://Scenes/TripScene.tscn");

func _ready():
	Tween.interpolate_property($TVMain/Light2D, "texture_scale", 1, 2, 2, Tween.TRANS_SINE, Tween.EASE_IN)
	Tween.start()
	$HUD.showDialog("tv", "main")
	# Disable menu in scene
	$HUD.disableMenu()

#func _process(delta):
#	pass

func _physics_process(_delta):
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
	
func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("ui_interact"):
		if hasSignal:
			MusicController.play("res://audio/cup_of_tea.ogg")
			$TVMain/TvContent.play("lofi-channel")
			$TVMain/TvContent.visible = !$TVMain/TvContent.visible
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


func _on_HUD_dialogFinished(dialogId):
		# Check if you have to do anything after this dialog finishes
	if	dialogId == "main":
		$HUD.showNotification("remote_minigame")
		$TVMain/TVRemote.show()
		mainDialogFinished = true
	if dialogId == "enjoying_the_music":
		$TVMain/TripTimer.start()
	if dialogId == "something_weird":
		global.go_to_scene("res://Scenes/TripScene.tscn");
		
		
func _on_InfraredPoint_area_entered(_area):
	hasSignal = true
	$TVMain/InfraredPoint/active.show()


func _on_InfraredPoint_area_exited(_area):
	hasSignal = false
	$TVMain/InfraredPoint/active.hide()


func _on_HUD_notificationClosed():
	canMoveRemote = true


func _on_TripTimer_timeout():
	Tween.interpolate_property(MusicController.audioPlayer, "pitch_scale", 1.0, 0.1, 5, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	Tween.start()
	$HUD.showDialog("tv", "something_weird");


func _on_VisibilityNotifier2D_screen_exited():
	$HUD.showDialog("tv", "enjoying_the_music")

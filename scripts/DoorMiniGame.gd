extends Node2D

var mousePosition
var direction
var VELOCITY = 400
var move = false
var showDialog = true
onready var dialogProgressTimer = $DialogProgressTimer
var prompts = ["Shit", "Shiiiiiiit", "This can't be happening", "Aaaah", "WTF!!!!"]
var font

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	HUD.disableMenu()
	HUD.connect("dialogFinished", self, "_on_HUD_dialogFinished")
	yield(get_tree().create_timer(0.3), "timeout")
	HUD.showNotification("doorknob_minigame")
	
	font = DynamicFont.new()
	font.font_data = load("res://fonts/Kenney High.ttf")
	font.size = 32

func _physics_process(delta):
	if move:
		$Knob.move_and_slide(direction * VELOCITY)
	
func _input(event):
	if event is InputEventMouseMotion || event is InputEventMouseButton:
		get_viewport().unhandled_input(event)

func _on_Area2D_mouse_entered():
	move = true
	mousePosition = get_local_mouse_position()
	direction = mousePosition.direction_to($Knob.position)
	
	if showDialog:
		HUD.showDialog("door", "move")
		dialogProgressTimer.start()
		


func _on_Area2D_mouse_exited():
	move = false
	showDialog = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		var label = Label.new()
		label.rect_position = get_local_mouse_position()
		label.set_rotation(deg2rad(randi() % 90))
		label.text = prompts[randi() % prompts.size()]
		label.set("custom_fonts/font", font)
		add_child(label)
		yield(get_tree().create_timer(1.5), "timeout")
		label.hide()

func _on_labelTimer_timeout(label):
	label.hide()


func _on_Center_mouse_entered():
	VELOCITY = 800


func _on_HUD_dialogFinished(id):
	match id:
		"move":
			$DialogTimer.start()
		"out":
			$SoundTimer.start()
		"sound":
			yield(get_tree().create_timer(1.0), "timeout")
			SceneChanger.change_scene("Basement")


func _on_DialogTimer_timeout():
	HUD.showDialog("door", "out")


func _on_SoundTimer_timeout():
	$teleportSound.play()

func _on_teleportSound_finished():
	yield(get_tree().create_timer(1.0), "timeout")
	HUD.showDialog("door", "sound")


func _on_DoorMiniGame_tree_exited():
	HUD.menuDisabled = false


func _on_DialogProgressTimer_timeout():
	HUD.loadDialog()

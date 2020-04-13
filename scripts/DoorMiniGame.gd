extends Node2D

var mousePosition
var direction
var VELOCITY = 400
var move = false
var showDialog = true
var prompts = ["Shit", "Shiiiiiiit", "This can't be happening", "Aaaah", "WTF!!!!"]
var font

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$HUD.disableMenu()
	$HUD.showNotification("doorknob_minigame")
	
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
		$HUD.showDialog("door", "move")


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
	if id == "move":
		$DialogTimer.start()


func _on_DialogTimer_timeout():
	$HUD.showDialog("door", "out")
	$SoundTimer.start()


func _on_SoundTimer_timeout():
	$monsterSnarl.play()


func _on_monsterSnarl_finished():
	$monsterSnarl.stop()

extends Node2D

var mousePosition
var direction
var move = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if move:
		$Knob.move_and_slide(direction * 400)
	
func _input(event):
	if event is InputEventMouseMotion || event is InputEventMouseButton:
		get_viewport().unhandled_input(event)


func _on_Area2D_mouse_entered():
	move = true
	mousePosition = get_local_mouse_position()
	direction = mousePosition.direction_to($Knob.position)


func _on_Area2D_mouse_exited():
	move = false

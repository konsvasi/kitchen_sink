extends Node2D

var activeArea;
const SHADER = preload("res://shaders/outline.shader")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _on_Area2D_area_entered(area):
	print('Entered: ', area)
	activeArea = area;


func _on_GoBackButton_pressed():
	global.previous_scene = "fridge"
	global.go_to_scene($GoBackButton.nextScene);


func _on_Area2D_mouse_entered():
	$sandwich.material.shader = SHADER
	print('Entered me')

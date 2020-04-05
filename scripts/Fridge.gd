extends Node2D

var activeArea
const SHADER = preload("res://shaders/outline.shader")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_Area2D_area_entered(area):
	print('Entered: ', area)
	activeArea = area;

func takeItemById(id):
	print('add item to inventory: ', id)
	PlayerVariables.setItem(id)
	if id == "blt_sandwich":
		$Sandwich.queue_free()

# Signals
func _on_GoBackButton_pressed():
	global.previous_scene = "fridge"
	global.go_to_scene($GoBackButton.nextScene);
		
func _on_Sandwich_grabItemById(id):
	takeItemById(id)

func _on_HotSauce_grabItemById(id):
	takeItemById(id)

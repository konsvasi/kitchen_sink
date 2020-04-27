extends Node2D

var activeArea
const SHADER = preload("res://shaders/outline.shader")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	for item in KeySceneItems.keySceneItems["fridge"]:
		if item == "blt_sandwich" && KeySceneItems.keySceneItems["fridge"][item].taken == true:
			$Sandwich.queue_free()
		if item == "hot_sauce" && KeySceneItems.keySceneItems["fridge"][item].taken == true:
			$HotSauce.queue_free()
			

func _input(event):
	get_viewport().unhandled_input(event)

func _on_Area2D_area_entered(area):
	activeArea = area;

func takeItemById(id):
	print('add item to inventory: ', id)
	PlayerVariables.setItem(id)
	if id == "blt_sandwich":
		KeySceneItems.setTaken("fridge", "blt_sandwich")
		$Sandwich.queue_free()
	elif id == 'hot_sauce':
		KeySceneItems.setTaken("fridge", "hot_sauce")
		$HotSauce.queue_free()	

# Signals
func _on_GoBackButton_pressed():
	global.previous_scene = "fridge"
	global.go_to_scene($GoBackButton.nextScene);
		
func _on_Sandwich_grabItemById(id):
	takeItemById(id)

func _on_HotSauce_grabItemById(id):
	takeItemById(id)


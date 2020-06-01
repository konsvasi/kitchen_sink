extends Node2D

var activeArea
onready var button = $GoBackButton
onready var goBackButton = $GoBackButton
const SHADER = preload("res://shaders/outline.shader")
const DEFAULT_TEXTURE = preload("res://ui/back_button.png")
const HOVER_TEXTURE = preload("res://ui/back_button_hover.png")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	for item in KeySceneItems.keySceneItems["fridge"]:
		if item == "blt_sandwich" && KeySceneItems.keySceneItems["fridge"][item].taken == true:
			$Sandwich.queue_free()
		if item == "hot_sauce" && KeySceneItems.keySceneItems["fridge"][item].taken == true:
			$HotSauce.queue_free()
			

func _input(event):
	get_viewport().unhandled_input(event)

	
#func _on_Area2D_area_entered(area):
#	print('area', area)
#	activeArea = area;

func takeItemById(id):
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
	SceneChanger.change_scene($GoBackButton.nextScene)
		
func _on_Sandwich_grabItemById(id):
	takeItemById(id)

func _on_HotSauce_grabItemById(id):
	takeItemById(id)


func _on_Area2D_mouse_entered():
	goBackButton.set_texture(HOVER_TEXTURE)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		SceneChanger.change_scene('House_inside')


func _on_Area2D_mouse_exited():
	goBackButton.set_texture(DEFAULT_TEXTURE)

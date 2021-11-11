extends Node

onready var root = get_tree().get_root()
var prev_scene_position = Vector2();
var current_scene = null;
var previous_scene = 'default'
var next_scene = null;
var PlayerNode = preload("res://scenes/Player.tscn").instance()
var Player = preload("res://scripts/Player.gd").new()
var playerPosition = Vector2(0, 0)
# Used to handle interaction when dialog is open
var isDialogOpen = false
var state = "default"
var DEBUG = false

func _ready():
#	var root = get_tree().get_root();
	current_scene = root.get_child( root.get_child_count() -1 )

func save_player_position(position: Vector2) -> void:
	playerPosition = position

func _deferred_goto_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	print('current_scene: ', current_scene.name, ' path:', path)
	get_tree().set_current_scene(current_scene)
	get_tree().get_root().add_child(current_scene)

func set_previous_scene(sceneName : String) -> void:
	print('PREVIOUS_SCENE:', sceneName)
	previous_scene = sceneName.to_lower();
	
func get_previous_scene() -> String:
	print('prevScene:', previous_scene.to_lower())
	return previous_scene.to_lower()

func get_current_scene_name() -> String:
	var weak_ref = weakref(current_scene)
	if (!weak_ref.get_ref()):
		current_scene = root.get_child( root.get_child_count() -1 )
	
	return current_scene.name.to_lower()


func setState(state : String) -> void:
	self.state = state

func getState() -> String:
	return self.state

extends Node

var prev_scene_position = Vector2();
var current_scene = null;
var previous_scene = 'default'
var next_scene = null;
var PlayerNode = preload("res://scenes/Player.tscn").instance()
var Player = preload("res://scripts/Player.gd").new()
# Used to handle interaction when dialog is open
var isDialogOpen = false

func _ready():
	var root = get_tree().get_root();
	current_scene = root.get_child( root.get_child_count() -1 )

func go_to_scene(nextScene : String) -> void:
	print("currentScene", get_tree().get_current_scene().get_name(), ' next scene', nextScene)
	set_previous_scene(get_tree().get_current_scene().get_name())
	call_deferred("_deferred_goto_scene", nextScene);

func go_to_sceneNew(nextSceneName : String) -> void:
	print("currentScene", get_tree().get_current_scene().get_name(), ' next scene', nextSceneName)
	var formattedSceneName = "res://Scenes/" + nextSceneName + ".tscn"
	set_previous_scene(get_tree().get_current_scene().get_name())
	call_deferred("_deferred_goto_scene", formattedSceneName);

func _deferred_goto_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func set_previous_scene(sceneName : String) -> void:
	previous_scene = sceneName.to_lower();
	
func get_previous_scene() -> String:
	return previous_scene.to_lower()

func wait(timeToWait : float) -> void:
	yield(get_tree().create_timer(timeToWait), "timeout")

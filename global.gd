extends Node

var prev_scene_position = Vector2();
var current_scene = null;
var previous_scene = null;
var next_scene = null;
var PlayerNode = preload("res://Player.tscn").instance()
var Player = preload("res://Player.gd").new();
var beforeMenuOpenPosition = null

func _ready():
	var root = get_tree().get_root();
	current_scene = root.get_child( root.get_child_count() -1 )
	print(current_scene);

func go_to_scene(nextScene):
	print("Next scene: ", nextScene);
	call_deferred("_deferred_goto_scene", nextScene);
	
func _deferred_goto_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

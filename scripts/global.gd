extends Node

var prev_scene_position = Vector2();
var current_scene = null;
var previous_scene = null;
var next_scene = null;
var PlayerNode = preload("res://scenes/Player.tscn").instance()
var Player = preload("res://scripts/Player.gd").new();
# Used to handle interaction when dialog is open
var isDialogOpen = false

func _ready():
	var root = get_tree().get_root();
	current_scene = root.get_child( root.get_child_count() -1 )

func go_to_scene(nextScene):
	call_deferred("_deferred_goto_scene", nextScene);
	
func _deferred_goto_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

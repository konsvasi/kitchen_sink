extends Control

var nextScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play() -> void:
	$ColorRect/AnimationPlayer.play("transition")

func change_scene(scene:String) -> void:
	global.go_to_scene(scene)

extends Area2D

const type = "Portal";
export var areaName = "";
export(String, FILE, "*.tscn") var nextScene

# This is the node where the player spanwns
# after the scene transition
export var outArea = "";
export var pathToScene = "";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


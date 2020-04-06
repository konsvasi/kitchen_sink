extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# set action needed items
	if PlayerVariables.usedKeyItems.has("special_mushrooms"):
		print("He has mushrooms in his system")
		$Couch.actionNeeded = false
	else:
		print("He's clear")

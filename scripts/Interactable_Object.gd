extends Area2D

const type = "Interactable_Object"
export var areaName = ""
export var interactable = true
export var dialogId = ""
export var transitionOnInteract = false
export var actionNeeded = false
export var actionId = ""
export(String, FILE, "*.tscn") var nextScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

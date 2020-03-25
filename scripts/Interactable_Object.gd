extends Area2D

const type = "Interactable_Object";
export var areaName = ""
export var interactable = true;
export(Dictionary) var object_dictionary = {
	"opensDialog": false,
}
export var transitionOnInteract = false;
export(String, FILE, "*.tscn") var nextScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_content(dialogId):
	print(content[dialogId][0])
	return content[dialogId][0]

var content = {
	"desk": ['Finally my parents are gone...', 'Time to triiiiiiip!!!!!']
}
extends Node

func _ready():
	pass

func get_content(currentScene, dialogId):
	return content[currentScene][dialogId]

var content = {
	"desk": {
		"main": ['Ooh the mushrooms that B. left for me...', 'Time to triiiiiiip!!!!!']
	},
	"house_inside": {
		"painting": ['What a nice painting', 'Took me three years to make...']
	}
}
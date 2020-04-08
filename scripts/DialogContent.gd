extends Node

func _ready():
	pass

func get_content(currentScene, dialogId):
	return content[currentScene][dialogId]

var content = {
	"desk": {
		"main": ['Ooh the mushrooms that B. left for me...', 'Time to triiiiiiip!!!!!'],
		"empty": ['Such an empty desk']
	},
	"house_inside": {
		"painting": ['What a nice painting', 'Took me three years to make...']
	},
	"basement": {
		"special_mushrooms": ['I think I should eat the mushrooms before watching TV...']
	},
	"tv": {
		"main": ['Let\'s put some music videos...', 'wait first I have to turn on the TV']
	}
}

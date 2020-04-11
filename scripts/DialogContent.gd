extends Node

func _ready():
	pass

func get_content(currentScene, dialogId):
	return content[currentScene][dialogId]

func get_notification_content(notificationId):
	return notification_content[notificationId]
	
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
		"main": ['Let\'s put some music videos...', 'wait first I have to turn on the TV...'],
		"enjoying_the_music": ['Finally I can relax', 'These mushrooms should kick in in about a hour or so'],
		"something_weird": ['I feel weird...', 'Is it already happening??', 'WTF, what is the dosage of these mushrooms?'],
	},
	"trip": {
		"main": ['Oh boy, I\'ve never hade a comeup like this.', 'What is wrong with me?'],
		"take_it_easy": ['Take it easy dude...', "But take it!!!", "Goodbye, you are alone now."],
		"elf": ['Hello traveller, this is the hyperdimension. We didn\'t have any visitors for years.', 'How did you even get here?'],
		"elf_next": ['Don\'t ask questions, just let yourself go and everything will be fine.', 'Don\'t fight it.'],
		"human": ['What is happening???!!!??', 'Will this end...?'],
		"end": ['Better turn the TV off and go upstairs...']	
	}
}

var notification_content = {
	"remote_minigame": "Move the remote by pressing w,a,s.\n When the sensor changes color press x"
}

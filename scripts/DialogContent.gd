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
		"special_mushrooms": ['I think I should eat the mushrooms before watching TV...'],
		"intro": ['Who are you?', 'How did you get in here?'],
		"name": ['Don\'t know me?', 'I\'m Zong, son of no one']
	},
	"tv": {
		"main": ['Let\'s put some music videos...', 'wait first I have to turn on the TV...'],
		"enjoying_the_music": ['Finally I can relax', 'These mushrooms should kick in in about a hour or so'],
		"something_weird": ['I feel weird...', 'Is it already happening??', 'WTF, what is the dosage of these mushrooms?'],
		"return": ['Aah much better, I think I got lost in my thoughts for a moment', 'Maybe some fresh air will clear my mind'],
		"music_playing": ['Whaaat? Why is the music still playing??????????', 'This is not good']
	},
	"trip": {
		"main": ['Oh boy, I\'ve never hade a comeup like this.', 'What is wrong with me?'],
		"take_it_easy": ['Take it easy dude...', "But take it!!!", "Goodbye, you are alone now."],
		"elf": ['Hello traveller, this is the hyperdimension. We didn\'t have any visitors for years.', 'How did you even get here?'],
		"elf_next": ['Don\'t ask questions, just let yourself go and everything will be fine.', 'Don\'t fight it.'],
		"human": ['What is happening???!!!??', 'Will this end...?'],
		"end": ['Better turn the TV off and go upstairs...']	
	},
	"door": {
		"move": ['Aaaah the door knob is moving?', 'Am I imagining this?'],
		"out": ['I\'m locked, I\'m never getting out of here!!!'],
		"sound": ['What was this sound?', ' It probably came from the TV']
	}
}

var notification_content = {
	"remote_minigame": "Move the remote by pressing w,a,s.\n When the sensor changes color press x",
	"doorknob_minigame": "Click on the door knob to open the door."
}

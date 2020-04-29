extends Node

var names = {
	"you": "You",
	"zong": "Zong",
	"elf": "Elf",
	"terry": "Terry"
}

func _ready():
	pass

func get_content(currentScene, dialogId):
	return content[currentScene][dialogId]

func get_dialog_owner(currentScene, dialogId):
	return dialog_names[currentScene][dialogId]

func get_notification_content(notificationId):
	return notification_content[notificationId]
	
var content = {
	"desk": {
		"main": ['Ooh the mushrooms that B. left for me...', 'Time to triiiiiiip!!!!!'],
		"empty": ['Such an empty desk', 'I should probably head downstairs']
	},
	"house_inside": {
		"painting": ['What a nice painting', 'Took me three years to make...']
	},
	"basement": {
		"special_mushrooms": ['I think I should eat the mushrooms before watching TV...'],
		"intro": ['Who are you?', 'How did you get in here?'],
		"name": ['Don\'t know me?', 'I\'m Zong, son of no one'],
		"sense": ['This doesn\'t make any sense'],
		"explanation": ['It will make sense in a bit, Momo...',
			'you see, you didn\'t just consume some magic mushrooms.',
			'What you had the fortune to eat where mushrooms of the purest form, sacred artifacts, the symbol of our civilization.',
			'Tales tell that the mushroom chooses who will consume it and by the way it also says',
			'that during your trip you\'ll have to fight me',
			'Find a way to beat me and you\'ll be preciously awarded.'
		],
		"lose": ['And if I lose? What happens then?'],
		"explanation_continued": ['If you lose, you\'ll be stuck in an eternal trip.'],
		"fight_question": ['How should I fight you?',
			'I don\'t have anything, you sure look more prepared than me.',
			'This is unfair...'],
		"brain": ['Nonsense, you\'ve been born with the strongest weapon to ever exist...',
			'Your brain...',
			'with it your options are limitless.',
			'Now let us start!!!']
		
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

var dialog_names = {
	"desk": {
		"main": names.you,
		"empty": names.you
	},
	"house_inside": {
		"painting": names.you
	},
	"basement": {
		"special_mushrooms": names.you,
		"intro": names.you,
		"name": names.zong,
		"sense": names.you,
		"explanation": names.zong,
		"lose": names.you,
		"explanation_continued": names.zong,
		"fight_question": names.you,
		"brain": names.zong
		
	},
	"tv": {
		"main": names.you,
		"enjoying_the_music": names.you,
		"something_weird": names.you,
		"return": names.you,
		"music_playing": names.you
	},
	"trip": {
		"main": names.you,
		"take_it_easy": names.terry,
		"elf": names.elf,
		"elf_next": names.elf,
		"human": names.you,
		"end": names.you
	},
	"door": {
		"move": names.you,
		"out": names.you,
		"sound": names.you
	}
}

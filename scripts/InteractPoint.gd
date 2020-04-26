extends Area2D
export (bool) var isDialogInteraction
export (String) var dialogId
export (bool) var isTransitionInteraction
export (String) var transitionScene
# Needed when Player needs to do something before 
# being able to transition to next scene
export (String) var actionId
var actionNeeded
const type = 'interact_point'

func _ready():
	if actionId:
		actionNeeded = true

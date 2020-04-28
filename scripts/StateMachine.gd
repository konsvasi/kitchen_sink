extends Node

class_name StateMachine

var state = null setget setState
var previousState = null
var states = {}
onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		stateLogic(delta)
		# Returns a new state if a transition occurs
		var transition = getTransition(delta)
		
		if transition != null:
			setState(transition)
	else:
		print('false')
		set_process(false)
func stateLogic(delta):
	pass

func getTransition(delta):
	return null

func enterState(newState, oldState):
	pass

func exitState(oldState, newState):
	pass

func setState(newState):
	previousState = state
	state = newState
	
	if previousState != null:
		exitState(previousState, newState)
	
	if state != null:
		enterState(newState, previousState)

func addState(stateName):
	states[stateName] = states.size()

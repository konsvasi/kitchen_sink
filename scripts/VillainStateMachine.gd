extends StateMachine


func _ready():
	addState("idle")
	addState("fight")
	addState("attack")
	addState("guard")
	call_deferred("setState", states.idle)

func stateLogic(delta):
	if [states.attack].has(state):
		parent.applyAttack()
	getTransition(delta)
	

func getTransition(delta):
	match state:
		states.fight:
			parent.get_node('STATE_DEBUG').set_text(str(state))
			return states.attack

func enterState(newState, oldState):
	if newState == states.attack:
		parent.attack()
	elif newState == states.guard:
		print('guard')
	elif newState == states.fight:
		parent.showAura()


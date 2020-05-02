extends StateMachine

func _ready():
	parent.connect("trampleFinished", self, "_on_attack_finished")
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
		states.attack:
			parent.get_node('STATE_DEBUG').set_text(str(state))

func enterState(newState, oldState):
	if newState == states.attack && parent.canAttack:
		parent.attack()
	elif newState == states.guard:
		print('guard')
	elif newState == states.fight:
		parent.showAura()

func exitState(oldState, newState):
	print('exited ', oldState)
	if oldState == states.attack:
		if parent.attackToPerform == "trample":
			parent.resetAttack("trample")
	
func _on_attack_finished(attackName : String):
	print("ATTACKNAME:", attackName)
	yield(get_tree().create_timer(5), "timeout")
	setState(states.fight)

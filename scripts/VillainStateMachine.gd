extends StateMachine

var canAttack = false

func _ready():
	parent.connect("trampleFinished", self, "_on_attack_finished")
	parent.connect("attackFinished", self, "_on_attack_finished")
	parent.connect("cageFinished", self, "_on_attack_finished")
	
	addState("idle")
	addState("fight")
	addState("attack")
	addState("guard")
	addState("cutscene")
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
			canAttack = false
			parent.get_node('STATE_DEBUG').set_text(str(state))
		states.idle:
			parent.get_node('STATE_DEBUG').set_text(str(state))
			if canAttack:
				return states.fight
		states.cutscene:
			parent.get_node('STATE_DEBUG').set_text(str(state))
			

func enterState(newState, oldState):
	if newState == states.attack:
		parent.attack()
	elif newState == states.guard:
		parent.guard()
	elif newState == states.fight:
		parent.showAura()

#func exitState(oldState, newState):
#	print('exited ', oldState)
#	if oldState == states.attack:
#		if parent.attackToPerform == "trample":
#			parent.resetAttack("trample")
	

func _on_Villain_trampleFinished(attackName : String):
	print("ATTACKNAME", attackName)
	
	setState(states.idle)
	parent.get_node("AttackTimer").start()
	

func _on_attack_finished(attackName: String):
	print('finished: ', attackName)
	if attackName == 'cage':
		parent.resetAttack('cage')
	call_deferred("setState", states.idle)
	parent.get_node("AttackTimer").start()
	
func _on_AttackTimer_timeout():
	canAttack = true

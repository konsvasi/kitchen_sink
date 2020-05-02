extends StateMachine

func _ready():
	addState("walking")
	addState("in_dialog")
	addState("idle")
	addState("jumping")
	call_deferred("setState", states.idle)
	
	if global.DEBUG:
		parent.get_node("StateDebugLabel").show()


func _input(event):	
	if states.idle == state:
		if Input.is_action_just_pressed("ui_interact"):
			var activeArea = parent.activeArea
#			print('actArea: ', activeArea.dialogId, ' scene ', global.get_current_scene_name())
			if activeArea && activeArea.type == "interact_point":
				if activeArea.isDialogInteraction:
					HUD.showDialog(global.get_current_scene_name(), activeArea.dialogId)
				elif activeArea.isTransitionInteraction:
					if !activeArea.actionId:
						global.go_to_sceneNew(activeArea.transitionScene)
					elif activeArea.actionId:
						# check if action has been completed
						if activeArea.actionNeeded:
							HUD.showDialog(global.get_current_scene_name(), activeArea.actionId)
						else:
							global.go_to_sceneNew(activeArea.transitionScene)
		if Input.is_action_just_pressed("ui_accept"):
			parent.jump()
	if states.in_dialog == state:
		if Input.is_action_just_pressed("ui_interact"):
			HUD.loadDialog()
	if states.walking == state:
		if Input.is_action_just_pressed("ui_accept"):
			parent.jump()

func stateLogic(delta):
	if [states.idle, states.walking].has(state):
		parent.handleMovement(delta)
		parent.applyMovement()
	getTransition(delta)

func getTransition(delta):
	match state:
		states.idle:
#			print('state:', state)
			parent.get_node("StateDebugLabel").set_text(str(state))
			if parent.velocity.x != 0:
				return states.walking
			elif HUD.isDialogOpen():
				return states.in_dialog
		states.walking:
			parent.get_node("StateDebugLabel").set_text(str(state))
			if parent.velocity.x == 0:
				return states.idle
		states.in_dialog:
			parent.get_node("StateDebugLabel").set_text(str(state))
			if !HUD.isDialogOpen():
				return states.idle
				
func enterState(newState, oldState):
	match newState:
		states.idle:
			parent.get_node("AnimatedSprite").play("idle")
		states.in_dialog:
			print('you are in dialog state')

func exitState(oldState, newState):
	pass

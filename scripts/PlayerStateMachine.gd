extends StateMachine

func _ready():
	addState("walking")
	addState("in_dialog")
	addState("idle")
	addState("jumping")
	addState("stagger")
	addState("guard")
	addState("duck")
	call_deferred("setState", states.idle)
	
	if global.DEBUG:
		parent.get_node("StateDebugLabel").show()


func _input(event):	
	if states.idle == state:
		if Input.is_action_just_pressed("ui_interact"):
			var activeArea = parent.activeArea
#			print('actArea: ', activeArea.dialogId, ' scene ', global.get_current_scene_name())
#			if activeArea && activeArea.type == "interact_point":
			if "type" in activeArea:
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
		elif Input.is_action_pressed("guard"):
			call_deferred("setState", states.guard)
		elif Input.is_action_just_pressed("ui_accept"):
			parent.jump()
		elif Input.is_action_just_pressed("ui_down"):
			call_deferred("setState", states.duck)
	if states.in_dialog == state:
		if Input.is_action_just_pressed("ui_interact"):
			HUD.loadDialog()
	if states.walking == state:
		if Input.is_action_just_pressed("ui_accept"):
			parent.jump()
		elif Input.is_action_pressed("guard"):
			call_deferred("setState", states.guard)
		elif Input.is_action_just_pressed("ui_down"):
			call_deferred("setState", states.duck)
	if states.guard == state:
		if Input.is_action_just_released("guard"):
			call_deferred("setState", states.idle)
	if states.duck == state:
		if Input.is_action_just_released("ui_down"):
			call_deferred("setState", states.idle)

func stateLogic(delta):
	if [states.idle, states.walking, states.guard].has(state):
		parent.handleMovement(delta)
		parent.applyMovement()
	elif [states.stagger].has(state):
		parent.stagger(delta)
	getTransition(delta)

func getTransition(delta):
	match state:
		states.idle:
#			print('state:', state)
			parent.get_node("StateDebugLabel").set_text("idle")
			if parent.velocity.x != 0:
				return states.walking
			elif HUD.isDialogOpen():
				return states.in_dialog
		states.walking:
			parent.get_node("StateDebugLabel").set_text("walking")
			if parent.velocity.x == 0:
				return states.idle
		states.in_dialog:
			parent.get_node("StateDebugLabel").set_text("dialog")
			if !HUD.isDialogOpen():
				return states.idle
		states.stagger:
			parent.get_node("StateDebugLabel").set_text("stagger")
		states.guard:
			parent.get_node("StateDebugLabel").set_text("guard")
		states.duck:
			parent.get_node("StateDebugLabel").set_text("ducking")
			
func enterState(newState, oldState):
	match newState:
		states.idle:
			parent.get_node("AnimatedSprite").play("idle")
		states.stagger:
			parent.staggerAnimation()
		states.guard:
			parent.guard()
		states.duck:
			parent.duck()

func exitState(oldState, newState):
	match oldState:
		states.guard:
			parent.resetGuard()
		states.duck:
			parent.resetDuck()

func stagger():
	call_deferred("setState", states.stagger)

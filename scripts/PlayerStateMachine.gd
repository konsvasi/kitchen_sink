extends StateMachine

func _ready():
	addState("walking")
	addState("dialog")
	addState("idle")
	call_deferred("setState", states.idle)
	
	if global.DEBUG:
		parent.get_node("StateDebugLabel").show()

func _input(event):
#	print('state: ', state)
	if states.idle == state:
		if Input.is_action_just_pressed("ui_interact"):
			if global.getState() == "default":
				if (parent.activeArea is Area2D):
					if (parent.activeArea.type == "Interactable_Object"):
						print(parent.activeArea.actionNeeded, parent.activeArea.name)
						if parent.activeArea.transitionOnInteract && !parent.activeArea.actionNeeded:
							global.go_to_scene(parent.activeArea.nextScene)
						elif parent.activeArea.transitionOnInteract && parent.activeArea.actionNeeded:
							HUD.showDialog(get_parent().name.to_lower(), parent.activeArea.actionId)
							
						# Open dialog		
						elif parent.activeArea.dialogId:
							# Has to be fixed to take correct scene
							HUD.showDialog(global.current_scene, parent.activeArea.dialogId)
		#				else:
		#					# Progress dialog
		#					get_parent().get_node("HUD").loadDialog()
			
		if Input.is_action_pressed("ui_up"):		
			if global.next_scene != "" && global.next_scene != null:
				global.previous_scene = get_tree().get_current_scene().name;
				global.go_to_scene(global.next_scene);
	if states.dialog == state:
		print("I only progress the dialog and exit it")
		
func stateLogic(delta):	
	parent.handleMovement(delta)
	parent.applyMovement()
	getTransition(delta)

func getTransition(delta):
	match state:
		states.idle:
			print('state:', state)
			parent.get_node("StateDebugLabel").set_text(str(state))
			if parent.velocity.x != 0:
				return states.walking
		states.walking:
			parent.get_node("StateDebugLabel").set_text(str(state))
			if parent.velocity.x == 0:
				return states.idle

func enterState(newState, oldState):
	match newState:
		states.idle:
			parent.get_node("AnimatedSprite").play("idle")

func exitState(oldState, newState):
	pass

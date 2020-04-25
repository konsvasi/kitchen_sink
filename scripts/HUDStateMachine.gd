extends StateMachine


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	addState("dialog_inactive")
	addState("dialog_active")
	addState("menu")
	addState("hud_active")
	addState("hud_inactive")
	call_deferred("setState", states.dialog_inactive)

func stateLogic(delta):
	getTransition(delta)
	
#func _input(event):
#	if states.dialog_active == state:
#		if Input.is_action_just_pressed("ui_interact"):
##			HUD.loadDialog()
#			print('+2')
#	elif states.dialog_inactive == state:
#		if Input.is_action_just_pressed("ui_interact"):
#			print('+1')

func getTransition(delta):
	match state:
		states.dialog_inactive:
			if HUD.isDialogOpen():
				return states.dialog_active


func _on_HUD_dialogFinished():
	setState(states.dialog_inactive)

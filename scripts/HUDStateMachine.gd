extends StateMachine
onready var menu = parent.get_node("Menu")
onready var inventoryMenu = parent.get_node("InventoryMenu")
onready var notification = parent.get_node("Notification")

func _ready():
	addState("dialog_inactive")
	addState("dialog_active")
	addState("menu")
	addState("hud_active")
	addState("hud_inactive")
	addState("inventory_active")
	addState("notification_active")
	call_deferred("setState", states.hud_inactive)

func stateLogic(delta):
	getTransition(delta)
	
func _input(event):
	if states.hud_inactive == state:
		if Input.is_action_just_pressed("ui_open_menu"):
			menu.toggleMenu()
	elif states.hud_active == state:
		if Input.is_action_just_pressed("ui_open_menu"):
			menu.toggleMenu()
		if Input.is_action_just_pressed("ui_down"):
			parent.index += 1
			if parent.index == parent.menuOptions.size():
				parent.index = 0
			menu.selectOption(parent.index)
		elif Input.is_action_just_pressed("ui_up"):
			parent.index -= 1
			if parent.index < 0:
				parent.index = parent.menuOptions.size() - 1
			menu.selectOption(parent.index)
		elif Input.is_action_just_pressed("ui_interact"):
			if menu.visible:
				match parent.index:
					0:
						inventoryMenu.show()
	elif states.inventory_active == state:
			if Input.is_action_just_pressed("ui_interact"):
				inventoryMenu.handleInput()
	elif states.notification_active == state:
		if Input.is_action_just_pressed("ui_interact"):
			parent.emit_signal("notificationClosed")
			notification.hide()
			
func getTransition(delta):
	match state:
		states.hud_active:
			if !menu.visible:
				return states.hud_inactive
			elif inventoryMenu.visible:
				return states.inventory_active
		states.hud_inactive:
			if menu.visible:
				return states.hud_active
			elif notification.visible:
				return states.notification_active
		states.inventory_active:
			if !inventoryMenu.visible:
				return states.hud_active
		states.notification_active:
			if !notification.visible:
				return states.hud_inactive


func _on_HUD_dialogFinished(dialogId):
	setState(states.hud_active)

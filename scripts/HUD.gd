extends CanvasLayer

signal dialogFinished
signal notificationClosed
var index = 0
var menuOptions = ['Inventory', 'Options']
var dialog = []
var menuDisabled = false

func _ready():
	pass # Replace with function body.

func _unhandled_key_input(event):
	if !$InventoryMenu.visible:
		if event.is_action_pressed('ui_open_menu') && !menuDisabled:
			$Menu.toggleMenu()
		
		if Input.is_action_just_pressed("ui_interact"):
			# get selected element
			# transition to element menu scene
			print('notificaton visible?', $Notification.visible)
			if $Notification.visible:
				emit_signal("notificationClosed")
				$Notification.hide()
			if $Menu.visible:
				if index == 0:
					self.set_process_unhandled_key_input(false)
					$InventoryMenu.updateItems()
					
		
		if event.is_action_pressed('ui_down'):
			index += 1
			
			if index == menuOptions.size():
				index = 0
			$Menu.selectOption(index)
		
		if event.is_action_pressed('ui_up'):
			index = index - 1
			
			if index < 0:
				index = menuOptions.size() - 1
			$Menu.selectOption(index)	

func disableMenu():
	menuDisabled = true

func showNotification(notificationId):
	$Notification.setText(notificationId)
	$Notification.show()
	
func _on_InventoryMenu_hide():
	$InventoryMenu.clearItems()
	self.set_process_unhandled_key_input(true)

func showDialog(currentScene, dialogId):
	var dialog = DialogContent.get_content(currentScene, dialogId)
	$Dialogbox.setDialog(dialog)
	$Dialogbox.setId(dialogId)
	$Dialogbox.show()
	global.isDialogOpen = true

func loadDialog():
	$Dialogbox.loadDialog()

func _on_Dialogbox_dialogFinished(finishedDialogId):
	emit_signal("dialogFinished", finishedDialogId)

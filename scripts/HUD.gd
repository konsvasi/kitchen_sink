extends CanvasLayer

signal dialogFinished
signal notificationClosed
var index = 0
var menuOptions = ['Inventory', 'Options']
var dialog = []
var menuDisabled = false
onready var dialogBox = $BottomDialogContainer/Dialogbox

func _ready():
	pass # Replace with function body.

	
#func _input(event):
#	if !$InventoryMenu.visible:
#		if event.is_action_pressed('ui_open_menu') && !menuDisabled:
#			$Menu.toggleMenu()
#
#		if Input.is_action_just_pressed("ui_interact"):
#			# get selected element
#			# transition to element menu scene
#			if $Notification.visible:
#				emit_signal("notificationClosed")
#				$Notification.hide()
#				get_tree().paused = false
#
#			if global.getState() == "dialog":
#				loadDialog()	
#
#			if $Menu.visible:
#				if index == 0:
#					self.set_process_unhandled_key_input(false)
#					$InventoryMenu.updateItems()
#
#
#		if event.is_action_pressed('ui_down'):
#			index += 1
#
#			if index == menuOptions.size():
#				index = 0
#			$Menu.selectOption(index)
#
#		if event.is_action_pressed('ui_up'):
#			index = index - 1
#
#			if index < 0:
#				index = menuOptions.size() - 1
#			$Menu.selectOption(index)	

func disableMenu():
	menuDisabled = true

func showNotification(notificationId):
	$Notification.setText(notificationId)
	$Notification.show()
	get_tree().paused = true
	
func _on_InventoryMenu_hide():
	pass
#	$InventoryMenu.clearItems()
#	self.set_process_unhandled_key_input(true)

func showDialog(currentScene, dialogId, position="down"):
	if position == "up":
		$BottomDialogContainer.remove_child(dialogBox)
		$TopDialogContainer.add_child(dialogBox)
		
		
	dialog = DialogContent.get_content(currentScene, dialogId)
	var name = DialogContent.get_dialog_owner(currentScene, dialogId)
	dialogBox.setDialog(dialog, dialogId, name)
	dialogBox.show()
	global.isDialogOpen = true
#	yield(get_tree().create_timer(0.1), "timeout")
	global.setState("dialog")

func loadDialog():
	dialogBox.loadDialog()

func isDialogOpen():
	return dialogBox.visible

func updateItems():
	$InventoryMenu.updateItems()
	
# Should be called when dialog was displayed in top position
func resetDialogPosition():
	$TopDialogContainer.remove_child(dialogBox)
	$BottomDialogContainer.add_child(dialogBox)
	
func _on_Dialogbox_dialogFinished(finishedDialogId):
#	global.setState("default")
	emit_signal("dialogFinished", finishedDialogId)

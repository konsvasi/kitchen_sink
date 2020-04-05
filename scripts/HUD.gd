extends CanvasLayer

var index = 0
var menuOptions = ['Inventory', 'Options']
var dialog = []

func _ready():
	pass # Replace with function body.

func _unhandled_key_input(event):
	if !$InventoryMenu.visible:
		if event.is_action_pressed('ui_open_menu'):
			$Menu.toggleMenu()
		
		if Input.is_action_just_pressed("ui_interact"):
			# get selected element
			# transition to element menu scene
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


func _on_InventoryMenu_hide():
	$InventoryMenu.clearItems()
	self.set_process_unhandled_key_input(true)

func showDialog(currentScene, dialogId):
	var dialog = DialogContent.get_content(currentScene, dialogId)
	$Dialogbox.setDialog(dialog)
	$Dialogbox.show()
	global.isDialogOpen = true

func loadDialog():
	$Dialogbox.loadDialog()

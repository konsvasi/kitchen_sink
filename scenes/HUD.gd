extends CanvasLayer

var index = 0
var menuOptions = ['Inventory', 'Options']
func _ready():
	pass # Replace with function body.

func _unhandled_key_input(event):
	if event.is_action_pressed('ui_open_menu'):
		$Menu.toggleMenu()
	
	if event.is_action_pressed("ui_interact"):
		# get selected element
		# transition to element menu scene
		if $Menu.visible:
			if index == 0:
				$InventoryMenu.show()	
	
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

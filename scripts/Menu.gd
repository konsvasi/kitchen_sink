extends PanelContainer

var index = 0
var elements = ['Inventory', 'Options']
var WHITE = Color(1, 1, 1)
var YELLOW = Color(1, 4, 0)

func _ready():
	self.visible = false
	$VBoxContainer/Inventory.set("custom_colors/font_color", Color(1,4,0))
	set_process_unhandled_key_input(true)

#func _unhandled_key_input(event):
#	if event.is_action_pressed('ui_down'):
#		print('index:', index)
#		index = index + 1
#		if index == elements.size():
#			index = 0
#
#		get_node("VBoxContainer/" + elements[index]).set("custom_colors/font_color", YELLOW)
#
#		if index - 1 == 0:
#			get_node("VBoxContainer/Inventory").set("custom_colors/font_color", WHITE)
#		elif index - 1 < 0:
#			get_node("VBoxContainer/" + elements[elements.size() -1]).set("custom_colors/font_color", WHITE)	
	
#	if event.is_action_pressed('ui_up'):
#		index = index - 1
#
#		if index < 0:
#			index = elements.size() - 1
#
#		## Focus
#		get_node("VBoxContainer/" + elements[index]).set("custom_colors/font_color", YELLOW)
#
#		## Unfocus
#		if index - 1 == 0:
#			get_node("VBoxContainer/Inventory").set("custom_colors/font_color", WHITE)
#		elif index - 1 < 0:
#			get_node("VBoxContainer/" + elements[elements.size() -1]).set("custom_colors/font_color", WHITE)	

#	if event.is_action_pressed('ui_open_menu'):
##		global.beforeMenuOpenPosition = global.Player.get_global_position()
##		print('beforeMenuOpenPos: ', global.beforeMenuOpenPosition)
#		toggleMenu()

		
func toggleMenu():
	self.visible = !self.visible
	get_tree().set_pause(self.visible)

func selectOption(index):
	if index < 0:
		index = 0
		
	get_node("VBoxContainer/" + elements[index]).set("custom_colors/font_color", YELLOW)
		
	if index - 1 == 0:
		get_node("VBoxContainer/Inventory").set("custom_colors/font_color", WHITE)
	elif index - 1 < 0:
		get_node("VBoxContainer/" + elements[elements.size() -1]).set("custom_colors/font_color", WHITE)
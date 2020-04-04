extends PanelContainer

var index = 0
var elements = ['Inventory', 'Options']
var WHITE = Color(1, 1, 1)
var YELLOW = Color(1, 4, 0)

func _ready():
	self.visible = false
	$VBoxContainer/Inventory.set("custom_colors/font_color", Color(1,4,0))
	set_process_unhandled_key_input(true)
		
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

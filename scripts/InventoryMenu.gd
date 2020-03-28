extends Panel

var ItemSlot = load("res://scenes/ItemSlot.tscn")

## Replace with global player items
const itemDictionary = {
	0: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1
	},
	1: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1
	},
	2: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1
	},
	3: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1
	},
	4: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1
	},
}
func _ready():
	for item in itemDictionary:
#		print('item: ', itemDictionary[item])
		# create instances of ItemSlots within ItemContainer
		var itemSlotInstance = ItemSlot.instance()
		itemSlotInstance.setItemSlot(itemDictionary[item])
		$ItemContainer.add_child(itemSlotInstance)
		itemSlotInstance.connect("update_description", self, "on_update_description")
	
	# Focus first element
	$ItemContainer.get_child(0).grab_focus()
	print('has focus: ', $ItemContainer.get_child(0).has_focus(), ' focus:', get_focus_owner())

func _input(event):
	if Input.is_action_just_pressed("ui_interact"):
		print('focus owner:', get_focus_owner().get_name())

func on_update_description(value):
	print("update description", value)
	
func _on_BackButton_pressed():
	self.hide()

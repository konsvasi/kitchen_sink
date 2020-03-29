extends Panel

var ItemSlot = load("res://scenes/ItemSlot.tscn")

## Replace with global player items
const itemDictionary = {
	0: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1,
		"description": "A pack of dried shrooms."
	},
	1: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1,
		"description": "5 grams of dried shrooms."
	},
	2: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1,
		"description": "A pack of dried shrooms."
	},
	3: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1,
		"description": "A pack of dried shrooms."
	},
	4: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1,
		"description": "A pack of dried shrooms."
	},
}
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for item in itemDictionary:
#		print('item: ', itemDictionary[item])
		# create instances of ItemSlots within ItemContainer
		var itemSlotInstance = ItemSlot.instance()
		itemSlotInstance.setItemSlot(itemDictionary[item])
		$ItemContainer.add_child(itemSlotInstance)
		itemSlotInstance.connect("update_description", self, "on_update_description")
	
	# Focus first element
	$ItemContainer.get_child(0).grab_focus()

func _input(event):
	if Input.is_action_just_pressed("ui_interact"):
#		if ($ItemContainer.get_child_count() - 1 == 0):
#			print('doing nothing')
#			pass
			
		if get_focus_owner().id == "item_slot":
			$UseItemAudio.play()
			get_focus_owner().useItem()
			
		if get_focus_owner().id == "back_button":
			hide()	

func on_update_description(value):
	$ItemDescription.text = value
	
func _on_BackButton_pressed():
	self.hide()

func _on_ItemContainer_sort_children():
	if $ItemContainer.get_child_count() != 0:
		$ItemContainer.get_child(0).grab_focus()
	else:
		$EmptyInventoryMessage.show()
		# give focus to back button
		$BackButton.grab_focus()
extends Panel

var ItemSlot = load("res://scenes/ItemSlot.tscn")

## Replace with global player items
const itemDictionary = {
	0: {
		"itemName": "Shrooms",
		"iconPath": preload("res://items/pack_of_mushrooms.png"),
		"quantity": 1
	}
}
func _ready():
	for item in itemDictionary:
		print('item: ', itemDictionary[item])
		# create instances of ItemSlots within ItemContainer
		var itemSlotInstance = ItemSlot.instance()
		# pass arguments for item slot
		itemSlotInstance.setItemSlot(itemDictionary[item])
		# add to scene
		$ItemContainer.add_child(itemSlotInstance)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	## hint
	## go to previous scene where player is visible
	## and menu is open
	## example if you where in the house scene and entered inventory mode
	## when going back you should change to this scene
	## at the same position
	## store active scene when menu opens for the first time
	## store position when menu opens for first time
	print('change scene')
	self.hide()
#	get_tree().change_scene("res://scenes/House_inside.tscn")


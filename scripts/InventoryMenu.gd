extends Panel

## Replace with global player items
const itemDictionary = {
	0: {
		"itemName": "Shrooms",
		"itemIcon": preload("res://items/pack_of_mushrooms.png")
	}
}
func _ready():
	for item in itemDictionary:
		print('item: ', itemDictionary[item])


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


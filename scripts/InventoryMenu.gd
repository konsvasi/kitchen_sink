extends Panel

var ItemSlot = load("res://scenes/ItemSlot.tscn")

var heldItems = {}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	loadItemSlots()

func _process(delta):
	if $ItemContainer.get_child_count() != 0:
		$EmptyInventoryMessage.hide()

func loadItemSlots():
	for item in heldItems:
		var itemSlotInstance = ItemSlot.instance()
		itemSlotInstance.setItemSlot(heldItems[item])
		$ItemContainer.add_child(itemSlotInstance)
		itemSlotInstance.connect("update_description", self, "on_update_description")
		
		if $ItemContainer.get_child_count() > 0:
			$ItemContainer.get_child(0).grab_focus()
		else:
			$EmptyInventoryMessage.show()	
			
func _unhandled_key_input(event):
	if self.visible:
		if Input.is_action_just_pressed("ui_interact"):
	#		if ($ItemContainer.get_child_count() - 1 == 0):
	#			print('doing nothing')
	#			pass
			print('interact', get_focus_owner().id)
			if get_focus_owner():
				if get_focus_owner().id == "item_slot":
					$UseItemAudio.play()
					get_focus_owner().useItem()
					
				if get_focus_owner().id == "back_button":
					print('hide')
					self.hide()	

func on_update_description(value):
	$ItemDescription.text = value
	
func _on_BackButton_pressed():
	self.hide()

func _on_ItemContainer_sort_children():
	print("SORTED", $ItemContainer.get_child_count())
	if $ItemContainer.get_child_count() != 0:
		$ItemContainer.get_child(0).grab_focus()
	else:
		$EmptyInventoryMessage.show()
		# give focus to back button
		$BackButton.grab_focus()

func updateItems():
	heldItems = PlayerVariables.items
	loadItemSlots()
	self.show()

func clearItems():
	for child in $ItemContainer.get_children():
		child.queue_free()

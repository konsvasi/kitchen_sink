extends Panel

var ItemSlot = load("res://scenes/ItemSlot.tscn")

var heldItems = PlayerVariables.items

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	loadItemSlots()

func _process(delta):
	if $ItemContainer.get_child_count() != 0:
		$EmptyInventoryMessage.hide()

func loadItemSlots():
	clearItems()
	print('heldItems:', heldItems)
	for item in heldItems:
		var itemSlotInstance = ItemSlot.instance()
		itemSlotInstance.setItemSlot(heldItems[item])
		$ItemContainer.add_child(itemSlotInstance)
		itemSlotInstance.connect("update_description", self, "on_update_description")
		
		if $ItemContainer.get_child_count() > 0:
			$ItemContainer.get_child(0).grab_focus()
		else:
			$EmptyInventoryMessage.show()
			
func handleInput():
	if get_focus_owner():
#		print('interact inventory', get_focus_owner().id)`
		if get_focus_owner().id == "item_slot":
			$UseItemAudio.play()
			get_focus_owner().useItem()
		elif get_focus_owner().id == "back_button":
			self.hide()	
			
func on_update_description(value):
	$ItemDescription.show()
	$ItemDescription.text = value
	
func _on_BackButton_pressed():
	self.hide()

func _on_ItemContainer_sort_children():
	if $ItemContainer.get_child_count() != 0:
		$ItemContainer.get_child(0).grab_focus()
	else:
		$EmptyInventoryMessage.show()
		$ItemDescription.hide()
		# give focus to back button
		$BackButton.grab_focus()

func updateItems():
	loadItemSlots()

func clearItems():
	for child in $ItemContainer.get_children():
		child.queue_free()

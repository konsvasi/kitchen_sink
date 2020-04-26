extends Control

signal update_description

var id = "item_slot"
var itemId
var itemName
var isKeyItem = false
# can be path or resource
var iconPath
var quantity
var description

func _ready():
	focus_mode = Control.FOCUS_ALL

# Dictionary object with key for
# name, icon path and quantity
func setItemSlot(item):
	itemId = item.id
	itemName = item.name
	$ItemButton.texture_normal = load(item.image_path)
	updateQuantityText(item.quantity)
	quantity = item.quantity
	description = item.description

func _on_ItemSlot_focus_entered():
	$FocusRect.show()
	emit_signal("update_description", description)

func useItem ():
	quantity -= 1
	#maybe play sound so that user knows that item was used
	if quantity != 0:
		updateQuantityText(quantity)
	else:
		#Remove item from PlayerVariables items
		PlayerVariables.items.erase(itemId)
		
		if isKeyItem(itemId):
			print('current_scene name', get_tree().get_current_scene().get_name(), ' current scene ', get_tree().get_current_scene())
			if ItemStore.getItem(itemId).interactScene == get_tree().get_current_scene().get_name().to_lower():
					get_tree().get_current_scene().updateInteractPoints(itemId)
			PlayerVariables.setUsedKeyItem(itemId)
		
		queue_free()		

func isKeyItem(itemId):
	return ItemStore.getItem(itemId).isKeyItem
	
func updateQuantityText(itemQuantity):
	$Quantity.text = str(itemQuantity)
	
func _on_ItemSlot_focus_exited():
	$FocusRect.hide()

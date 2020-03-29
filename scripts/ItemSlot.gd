extends Control

signal update_description

var id = "item_slot"
var itemName
# can be path or resource
var iconPath
var quantity
var description

func _ready():
	print(has_focus())
	focus_mode = Control.FOCUS_ALL

# Dictionary object with key for
# name, icon path and quantity
func setItemSlot(item):
	$ItemButton.texture_normal = item.iconPath
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
		queue_free()		

func updateQuantityText(quantity):
	$Quantity.text = str(quantity)
	
func _on_ItemSlot_focus_exited():
	$FocusRect.hide()

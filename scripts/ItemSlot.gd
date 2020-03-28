extends Control

signal update_description

var itemName
# can be path or resource
var iconPath
var quantity
var description = "A pack of dried shrooms."

func _ready():
	print(has_focus())
	focus_mode = Control.FOCUS_ALL

# Dictionary object with key for
# name, icon path and quantity
func setItemSlot(item):
	$ItemButton.texture_normal = item.iconPath
	$Quantity.text = str(item.quantity)

func _on_ItemSlot_focus_entered():
	$FocusRect.show()
	emit_signal("update_description", description)


func _on_ItemSlot_focus_exited():
	$FocusRect.hide()

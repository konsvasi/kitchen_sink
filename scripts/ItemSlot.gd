extends Control

var itemName
# can be path or resource
var iconPath
var quantity

func _ready():
	pass # Replace with function body.

# Dictionary object with key for
# name, icon path and quantity
func setItemSlot(item):
	$ItemButton.texture_normal = item.iconPath
	$Quantity.text = str(item.quantity)
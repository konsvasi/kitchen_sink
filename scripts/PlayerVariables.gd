extends Node

var health = 50
var items = {}
var usedKeyItems = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setItem(itemId):
#	print('item', ItemStore.getItem(itemId))
	items[itemId] = ItemStore.getItem(itemId)

func setUsedKeyItem(itemId):
	usedKeyItems[itemId] = itemId
	print('usedKeyItems', usedKeyItems)
	
func hasUsed(itemId):
	return usedKeyItems.has(itemId)

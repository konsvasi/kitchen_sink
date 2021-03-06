extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getItem(itemId):
	return content[itemId]
	
var content = {
	"special_mushrooms": {
		"id": "special_mushrooms",
		"name": "Special mushrooms",
		"image_path": "res://items/pack_of_mushrooms.png",
		"description": "A pack of dried shrooms.",
		"isKeyItem": true,
		"interactScene": "basement",
		"quantity": 1
	},
	"blt_sandwich": {
		"id": "blt_sandwich",
		"name": "BLT sandwich",
		"image_path": "res://items/sandwich_v2.png",
		"description": "Just a sandwich",
		"isKeyItem": false,
		"quantity": 1
	},
	"hot_sauce": {
		"id": "hot_sauce",
		"name": "Hot sauce",
		"image_path": "res://items/hot_sauce.png",
		"description": "Fiery sriracha",
		"isKeyItem": false,
		"quantity": 1
	}
}

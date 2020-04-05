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
		"quantity": 1
	},
	"blt_sandwich": {
		"id": "blt_sandwich",
		"name": "BLT sandwich",
		"image_path": "res://items/sandwich_v2.png",
		"description": "Just a sandwich",
		"quantity": 1
	}
}

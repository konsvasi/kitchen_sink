extends Node

# Contains all the items that shouldn't be displayed in a scene
# once they've been take by the player
# key is the scene
# each item has a variable that shows false if it hasn't been take by the user
var keySceneItems = {
	"desk": {
		"special_mushrooms": { "taken": false }
	},
	"fridge": {
		"hot_sauce": { "taken": false },
		"blt_sandwich": { "taken": false }
	}
}

func setTaken(scene, itemId):
	keySceneItems[scene][itemId].taken = true

func _ready():
	pass # Replace with function body.

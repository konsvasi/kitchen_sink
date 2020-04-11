extends Node

var actions = {
	"special_mushrooms": PlayerVariables.hasUsed("special_mushrooms"),
	"doorknob_game_active": false
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func getAction(actionId):
	return actions[actionId]

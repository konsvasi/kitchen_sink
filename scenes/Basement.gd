extends Node2D

var interact_points = []

# Called when the node enters the scene tree for the first time.
func _ready():
	interact_points = get_tree().get_nodes_in_group('interact_point')
	updateInteractPoints('test_id')
	# set action needed items
	if PlayerVariables.usedKeyItems.has("special_mushrooms"):
		$Couch.actionNeeded = false

func updateInteractPoints(itemId):
	for point in interact_points:
		if itemId == point.actionId:
			point.actionNeeded = false
	

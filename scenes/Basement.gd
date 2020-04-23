extends Node2D

var villainScene = preload("res://scenes/Villain.tscn")
var interact_points = []

func _ready():
#	if global.get_previous_scene() == 'tv':
#		$Player.set_position($Couch.position)
	print(global.get_previous_scene())
	HUD.connect("dialogFinished", self, "_on_HUD_dialogFinished")
	global.previous_scene = "doorminigame"
	match global.get_previous_scene():
		"tv":
			$Player.set_position($Couch.position)
			global.state = "default"
		"doorminigame":
			var villain = villainScene.instance()
			villain.position = $VillainStartPosition.position
			add_child(villain)
			villain.get_node("KinematicBody2D/AnimationPlayer").play("float_idle")
			$PrefightTrigger/CollisionShape2D.disabled = false
	interact_points = get_tree().get_nodes_in_group('interact_point')
	updateInteractPoints('test_id')
	# set action needed items
	if PlayerVariables.usedKeyItems.has("special_mushrooms"):
		$Couch.actionNeeded = false
	print('doorknob active?', Actions.getAction("doorknob_game_active"))
	if Actions.getAction("doorknob_game_active"):
		# Change to minigame scene
		$DoorToHouse.nextScene = "res://scenes/DoorMiniGame.tscn"

func updateInteractPoints(itemId):
	for point in interact_points:
		if itemId == point.actionId:
			point.actionNeeded = false
	

func _on_PrefightTrigger_body_exited(body):
	global.setState("dialog")
	HUD.showDialog("basement", "intro")


func _on_HUD_dialogFinished(id):
	print("id", id)
	match id:
		"intro":
			global.setState("default")
			$PrefightTrigger.queue_free()
			HUD.showDialog("basement", "name")
		"name":
			print('finished with name dialog')
			yield(get_tree().create_timer(1.0), "timeout")
			global.go_to_scene("res://Scenes/CharacterIntro.tscn")
#			global.go_to_sceneNew("CharacterIntro")

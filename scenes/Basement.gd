extends Node2D

var villainScene = preload("res://scenes/Villain.tscn")
onready var interact_points = get_tree().get_nodes_in_group('interact_point_action_needed')

func _ready():
	HUD.connect("dialogFinished", self, "_on_HUD_dialogFinished")
	match global.get_previous_scene():
		"tv":
			$Player.set_position($couch_interact.position)
			global.state = "default"
		"doorminigame":
			var villain = villainScene.instance()
			villain.position = $VillainStartPosition.position
			add_child(villain)
			villain.get_node("KinematicBody2D/AnimationPlayer").play("float_idle")
			$PrefightTrigger/CollisionShape2D.disabled = false
		"characterintro":
			$Player.position = global.playerPosition
			# Add timer and dialog

	updateInteractPoints('special_mushrooms')
	print('doorknob active?', Actions.getAction("doorknob_game_active"))
	if Actions.getAction("doorknob_game_active"):
		# Change to minigame scene
		$door_to_house_interact.transitionScene = "DoorMiniGame"

func updateInteractPoints(itemId):
	for point in interact_points:
		if itemId == point.actionId && PlayerVariables.hasUsed(itemId):
			point.actionNeeded = false
	

func _on_PrefightTrigger_body_exited(body):
	global.setState("dialog")
	HUD.showDialog("basement", "intro")


func _on_HUD_dialogFinished(id):
	match id:
		"intro":
			global.setState("default")
			$PrefightTrigger.queue_free()
			HUD.showDialog("basement", "name")
		"name":
			print('finished with name dialog')
			yield(get_tree().create_timer(1.0), "timeout")
			global.save_player_position($Player.get_global_position())
			global.go_to_scene("res://Scenes/CharacterIntro.tscn")
#			global.go_to_sceneNew("CharacterIntro")

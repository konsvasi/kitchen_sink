extends Node2D

var villainScene = preload("res://scenes/Villain.tscn")
var villain
onready var melv = $Melv
onready var orb = $Orb
onready var orbTween = $OrbTween
var orbVelocity = Vector2.ZERO
var playerPosition = Vector2.ZERO
var moveOrb = false
var fightMode = false
onready var interact_points = get_tree().get_nodes_in_group('interact_point_action_needed')
onready var melvStartPosition = $Melv.global_position
signal givePowers

func _ready():
	HUD.connect("dialogFinished", self, "_on_HUD_dialogFinished")
	if global.DEBUG:
		global.previous_scene = "characterintro"
		
	match global.get_previous_scene():
		"tv":
			$Player.set_position($couch_interact.position)
			global.state = "default"
		"doorminigame":
			positionVillain()
			$PrefightTrigger/CollisionShape2D.disabled = false
		"characterintro":
			positionVillain()
			$Player.position = global.playerPosition
			# Add timer and dialog
			yield(get_tree().create_timer(0.5), "timeout")
			HUD.showDialog("basement", "sense")

	updateInteractPoints('special_mushrooms')

	if Actions.getAction("doorknob_game_active"):
		# Change to minigame scene
		$door_to_house_interact.transitionScene = "DoorMiniGame"

func _process(delta):
	if fightMode:
		if PlayerVariables.health < 80:
			villain.get_node("VillainStateMachine").canAttack = false
			if villain.attackToPerform == "trample":
				villain.moveBootToStart()
			melv.moveTowardsPlayer()
			fightMode = false
	
	if moveOrb:
		orbVelocity = ($Player.global_position - orb.position).normalized() * 25
		orb.move_and_slide(orbVelocity)
		
		if (playerPosition - orb.global_position).length() < 10:
			moveOrb = false
			fadeOrb()
			emit_signal("givePowers")
		
			
func updateInteractPoints(itemId):
	for point in interact_points:
		if itemId == point.actionId && PlayerVariables.hasUsed(itemId):
			point.actionNeeded = false
	

func _on_PrefightTrigger_body_exited(body):
	global.setState("dialog")
	HUD.showDialog("basement", "intro")

func fadeOrb() -> void:
	orbTween.interpolate_property(orb.get_node("OrbSprite"),
		'modulate', 
		Color(1.0, 1.0, 1.0, 1.0), 
		Color(1.0, 1.0, 1.0, 0.0),
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	orbTween.start()
	orb.get_node("Particles2D").emitting = false
	orb.queue_free()

func positionVillain():
	villain = villainScene.instance()
#	villain.position = $VillainStartPosition.position
	$VillainPath/PathToFollow.add_child(villain)
#	add_child(villain)
	villain.get_node("KinematicBody2D/AnimationPlayer").play("float_idle")
	
func _on_HUD_dialogFinished(id):
	match id:
		"intro":
			global.setState("default")
			$PrefightTrigger.queue_free()
			HUD.showDialog("basement", "name")
		"name":
			yield(get_tree().create_timer(1.0), "timeout")
			global.save_player_position($Player.get_global_position())
			global.go_to_scene("res://Scenes/CharacterIntro.tscn")
		"sense":
			yield(get_tree().create_timer(0.3), "timeout")
			HUD.showDialog("basement", "explanation")
		"explanation":
			yield(get_tree().create_timer(0.3), "timeout")
			HUD.showDialog("basement", "lose")
		"lose":
			yield(get_tree().create_timer(0.3), "timeout")
			HUD.showDialog("basement", "explanation_continued")
		"explanation_continued":
			yield(get_tree().create_timer(0.3), "timeout")
			HUD.showDialog("basement", "fight_question")
		"fight_question":
			yield(get_tree().create_timer(0.3), "timeout")
			HUD.showDialog("basement", "brain")
		"brain":
			villain.moveOnPath($VillainPath/PathToFollow)
		"begin":
			# Would be nice to show some fight intro screen
			villain.get_node("VillainStateMachine").setState(1)
			fightMode = true
		"melv":
			yield(get_tree().create_timer(0.3), "timeout")
			HUD.showDialog("basement", "zong_reply")
		"zong_reply":
			yield(get_tree().create_timer(0.3), "timeout")
			HUD.showDialog("basement", "melv_powers")
		"melv_powers":
			melv.givePowers()
		"melv_explain_powers":
			melv.moveOut(melvStartPosition)
			print("Show notification about powers and start fight after notification")
			HUD.showNotification("powers_explanation")


func _on_WallTrigger_body_entered(body):
	var borders = get_tree().get_nodes_in_group("borders")
	for border in get_tree().get_nodes_in_group("borders"):
		if border.get_node("CollisionShape"):
			border.get_node("CollisionShape").set_deferred("disabled", false)
		border.show()
	$WallTrigger.queue_free()
	yield(get_tree().create_timer(0.5), "timeout")
	HUD.showDialog("basement", "begin")


func _on_Melv_rotationFinished():
	moveOrb = true
	orb.position = melv.position
	orb.get_node("Particles2D").emitting = true
	orb.get_node("OrbSprite").show()
	orbTween.interpolate_property(orb.get_node("OrbSprite"),
		'modulate', 
		Color(1.0, 1.0, 1.0, 0.0), 
		Color(1.0, 1.0, 1.0, 1.0),
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	orbTween.start()
	playerPosition = get_tree().current_scene.get_node("Player").get_global_position()
	

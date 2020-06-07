extends Node2D

var velocity
var bootVelocity
var tween
var attacks = ['trample', 'laser', 'cage']
var playerPosition
var chargePosition
var villainVelocity
var trampleAttackCount = 0
var outsideScreen = false
var isInAttack = false
var attackToPerform
#onready var boot = get_tree().current_scene.get_node("Boot")
onready var boot = get_tree().get_root().get_node("Basement/Boot")
onready var basement = get_tree().current_scene
onready var cage = get_tree().get_root().get_node("Basement/Cage")
onready var cageWarning = get_tree().get_root().get_node("Basement/CageWarning")
onready var spriteTween = $KinematicBody2D/Sprite/SpriteTween
onready var sprite = $KinematicBody2D/Sprite
onready var villainBody = $KinematicBody2D
onready var stateMachine = $VillainStateMachine
var bulletScene = preload("res://scenes/Bullet.tscn")
var startPosition = Vector2(450, 132)
var isDemo = true
var cageCount = 0
var checkOverlap = false

signal trampleFinished
signal attackFinished
signal castFinished
signal cageFinished

func _ready():
	cage.connect("attackFinished", self, "_on_cage_finished")
	boot.connect("attackFinished", self, "_on_trample_attack_finished")
	boot.get_node("VisibilityNotifier2D").connect("screen_exited", self, "_on_boot_out")
	
func moveOnPath(pathToFollow : PathFollow2D) -> void:
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(pathToFollow, "unit_offset", 0, 1, 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func attack():
	attackToPerform = chooseAttack()
	print('attackToPerform:', attackToPerform)
	if attackToPerform == 'trample':
		trample()
	elif attackToPerform == 'laser':
		laser()
	elif attackToPerform == 'cage':
		cage()
	
func chooseAttack() -> String:
	if global.DEBUG:
		return "laser"
	return attacks[randi() % attacks.size()]

# Function called in delta
func applyAttack():
	match attackToPerform:
		"trample":
			boot.move_and_slide(bootVelocity)
		"cage":
			if checkOverlap:
				if cage.checkOverlap():
					get_tree().current_scene.get_node("Player/PlayerStateMachine").setState(4)
#					PlayerVariables.health -= 0.1
#					HUD.updateHealth(2)
#					emit_signal("updateHealth", 2)
					print('overlap:', cage.checkOverlap())
				
func trample():
	if trampleAttackCount <= 2:
		playerPosition = get_tree().current_scene.get_node("Player").get_global_position()
		# Move it towards player
		bootVelocity = (playerPosition - boot.get_global_position()).normalized() * 60
		# Do this 3 times
		trampleAttackCount += 1
		isInAttack = true
	elif trampleAttackCount == 3:
		isInAttack = false
		bootVelocity = (startPosition - boot.get_global_position()).normalized() * 70
		yield(get_tree().create_timer(0.1), "timeout")
		emit_signal("trampleFinished", "trample")
		trampleAttackCount = 0

func moveBootToStart():
	bootVelocity = (startPosition - boot.get_global_position()).normalized() * 70
	trampleAttackCount = 0
	isInAttack = false
	boot.isDemo = true
	

func laser() -> void:
	prepareBullet()
	
func shootBullets() -> void:
	var bullet = bulletScene.instance()
	var bullet2 = bulletScene.instance()
	var bullet3 = bulletScene.instance()
	add_child(bullet)
	yield(get_tree().create_timer(1.0),"timeout")
	add_child(bullet2)
	yield(get_tree().create_timer(1.0),"timeout")
	add_child(bullet3)
	yield(get_tree().create_timer(0.5),"timeout")
	emit_signal("attackFinished", 'laser')


func cage() -> void:
	playerPosition = get_tree().current_scene.get_node("Player").get_global_position()
	cageWarning.position = playerPosition
	cageWarning.position.y = playerPosition.y - 15
	cageWarning.get_node("WarnPlayer").play("warn")
	yield(get_tree().create_timer(1),"timeout")
	cage.position = playerPosition
	cage.position.y = playerPosition.y - 15
	cage.get_node("AnimationPlayer").play("shock")
	yield(get_tree().create_timer(2.0),"timeout")
	
	# Attack didn't hit player
	# stop attack
	if (!cage.checkOverlap()):
		emit_signal("cageFinished", "cage")


func resetAttack(attackName : String) -> void:
	if attackName == "trample":
		boot.position = startPosition
		bootVelocity = Vector2(0,0)
	elif attackName == "cage":
#		cage.hide()
#		cageWarning.hide()
		cage.moveToStart()
		cageWarning.position = Vector2.ZERO
#		cage.get_node("CageArea/CollisionShape2D").call_deferred("disabled", true)
#		cage.get_node("StaticBodyLeft/cageLeft").call_deferred("disabled", true)
#		cage.get_node("StaticBodyRight/cageRight").call_deferred("disabled", true)

func setState(index) -> void:
	stateMachine.setState(index)
	
func showAura() -> void:
	$KinematicBody2D/Aura.show()

func reveal() -> void:
	spriteTween.interpolate_property(sprite, 
		'modulate', 
		Color(1,1,1,0), 
		Color(1,1,1,1),
		1.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN)
	spriteTween.start()
	
func guard():
	print('guarding')

func prepareBullet():
	spriteTween.interpolate_property(
		$KinematicBody2D/Sprite, 
		"modulate", 
		Color(1.0,1.0,1.0), 
		Color(0, 1.3, 1.5),1.0,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	spriteTween.start()
	
func _on_trample_attack_finished(attack : String):
	yield(get_tree().create_timer(0.3), "timeout")
	bootVelocity = (startPosition - boot.get_global_position()).normalized() * 70

func _on_boot_out():
	outsideScreen = true
	isInAttack = false
	bootVelocity = Vector2(0,0)
	yield(get_tree().create_timer(0.5), "timeout")
	trample()


func _on_SpriteTween_tween_completed(object, key):
	print("get state: ", stateMachine.getState())
	if (key == ':modulate' && stateMachine.getState() == 2):
		print('key', key)
		shootBullets()
		$KinematicBody2D/Sprite.modulate = Color(1.0, 1.0, 1.0)

func _on_cage_finished(attack : String):
	emit_signal("cageFinished", "cage")


func _on_Area2D_body_entered(body):
	if body.name == "Ball":
		body.queue_free()
		var damage = 9
		VillainVariables.health -= damage
		HUD.updateHealth(damage, "villain")

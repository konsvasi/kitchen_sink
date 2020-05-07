extends Node2D

var velocity
var bootVelocity
var tween
var attacks = ['trample', 'charge', 'laser']
var playerPosition
var chargePosition
var villainVelocity
var trampleAttackCount = 0
var outsideScreen = false
var isInAttack = false
var attackToPerform
onready var boot = get_tree().current_scene.get_node("Boot")
onready var basement = get_tree().current_scene
onready var villainBody = $KinematicBody2D
var startPosition = Vector2(450, 132)

signal trampleFinished


func _ready():
	boot.connect("attackFinished", self, "_on_trample_attack_finished")
	boot.get_node("VisibilityNotifier2D").connect("screen_exited", self, "_on_boot_out")
	
func moveOnPath(pathToFollow : PathFollow2D) -> void:
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(pathToFollow, "unit_offset", 0, 1, 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func attack():
	attackToPerform = attacks[1]
	print('attackToPerform:', attackToPerform)
	if attackToPerform == 'trample':
		trample()
	elif attackToPerform == 'charge':
		charge()
	elif attackToPerform == 'laser':
		laser()

# Function called in delta
func applyAttack():
	match attackToPerform:
		"trample":
			boot.move_and_slide(bootVelocity)
		"charge":
			villainVelocity = villainBody.position.direction_to(chargePosition) * 50
			villainVelocity = villainBody.move_and_slide(villainVelocity)
				
func trample():
	print('count: ', trampleAttackCount)
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

func charge():
	# get player position
	chargePosition = get_tree().current_scene.get_node("Player").get_global_position()
	print('playerPosition', playerPosition)
	# charge towards him
#	villainVelocity = (playerPosition - self.get_global_position()).normalized() * 80
	# if hit knockback player

func laser():
	# get player position
	# shoot laser for 3 seconds
	# continuous damage to player if hit
	pass

# Probably not needed anymore
func resetAttack(attackName : String) -> void:
	if attackName == "trample":
		boot.position = startPosition
		bootVelocity = Vector2(0,0)
	
func showAura():
	$KinematicBody2D/Aura.show()

func guard():
	print('guarding')

func _on_trample_attack_finished(attack : String):
	yield(get_tree().create_timer(0.3), "timeout")
	bootVelocity = (startPosition - boot.get_global_position()).normalized() * 70

func _on_boot_out():
	print('outside screen')
	outsideScreen = true
	isInAttack = false
	bootVelocity = Vector2(0,0)
	yield(get_tree().create_timer(0.5), "timeout")
	trample()

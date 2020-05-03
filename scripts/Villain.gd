extends Node2D

var velocity
var bootVelocity
var tween
var attacks = ['trample', 'charge', 'laser']
var playerPos
var trampleAttackCount = 0
var isReturning = false
var canAttack = true
onready var boot = get_tree().current_scene.get_node("Boot")
onready var basement = get_tree().current_scene
var startPosition = Vector2(450, 132)

signal trampleFinished


func _ready():
	boot.connect("attackFinished", self, "_on_trample_attack_finished")
	
func moveOnPath(pathToFollow : PathFollow2D) -> void:
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(pathToFollow, "unit_offset", 0, 1, 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func attack():
	var attackToPerform = attacks[0]
	print('attackToPerform:', attackToPerform)
	if attackToPerform == 'trample':
		trample()

func trample():
	# Get boot node
#	var boot = get_tree().current_scene.get_node("Boot")
#	print('Boot', boot)
	# Get player position
	canAttack = false
	if trampleAttackCount <= 2:
		playerPos = get_tree().current_scene.get_node("Player").get_global_position()
	#	print('playerPos', playerPos)
		# Move it towards player
		bootVelocity = (playerPos - boot.get_global_position()).normalized() * 60
		# Do this 3 times
		trampleAttackCount += 1
	else:
		isReturning = true
		bootVelocity = (startPosition - boot.get_global_position()).normalized() * 70
		print('Can attack now')
		canAttack = true
		emit_signal("trampleFinished")

# Function called in delta
func applyAttack():
#	print('boot.globalPos', boot.get_global_position())
#	if (playerPos - boot.get_global_position() > 5):
	boot.move_and_slide(bootVelocity)
	
	if isReturning && (boot.get_global_position() - basement.get_node("BootStartPosition").get_global_position()).length() < 5:
		print('reached start position')
		bootVelocity = Vector2(0,0)
		isReturning = false
		yield(get_tree().create_timer(0.5), "timeout")
		trample()

func resetAttack(attackName : String) -> void:
	if attackName == "trample":
		boot.position = startPosition.position
		bootVelocity = Vector2(0,0)
	
func showAura():
	$KinematicBody2D/Aura.show()

func _on_trample_attack_finished(attack : String):
	print('attack finished, check count, repeat attack')
	yield(get_tree().create_timer(0.3), "timeout")
	isReturning = true
	bootVelocity = (startPosition - boot.get_global_position()).normalized() * 70

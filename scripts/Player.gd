extends KinematicBody2D

const SPEED = 60
const GRAVITY = 75
const JUMP_FORCE = 65
const FLOOR = Vector2(0, -1)
export var health = 50
var items = {}
var velocity = Vector2()
var insideDoor = false
var activeArea
var activeOutArea = ""
var isMenuOpen = false
var projectileDirection
var canWalkAgain = false
var friction = 0.1

func _ready():
	velocity.y = GRAVITY
	HUD.connect("dialogFinished", self, "_on_HUD_dialogFinished")
	
func handleMovement(delta):
	velocity.y += GRAVITY * delta
#	print('direction:', -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right")))
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED;
		$AnimatedSprite.play("walk_right");
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED;
		$AnimatedSprite.play("walk_left");
	else:
		velocity.x = 0;
#		$AnimatedSprite.play("idle");
	
	velocity.y += GRAVITY * delta
	
func applyMovement():
	move_and_slide(velocity, Vector2(0, 0))

func stagger(delta):
	velocity.x = lerp(velocity.x, 0, friction)
	velocity.y = lerp(velocity.y, 0, friction)
	move_and_collide(Vector2(velocity.x, velocity.y) * SPEED * delta)

func jump():
	velocity.y = -JUMP_FORCE

func get_node_from_current_scene(nodeName):
	return get_tree().get_current_scene().get_node(nodeName)

func dialog_open(dialogContent):
	print(dialogContent)

func getStateMachine():
	return $PlayerStateMachine

func staggerAnimation():
	canWalkAgain = false
	$AnimationPlayer.play("stagger")
	velocity.x = -2 # should be the opposite direction of projectile
	$StaggerTimer.start()
	
func _on_Area2D_area_entered(area):
	# First check if Area2d is a Portal or an Interactable Object
	activeArea = area
	if 'type' in area:
		if area.type == 'interaction_point':
			if area.isDialogInteraction:
				$ThoughtBubble.animation = 'dialog_interaction'
			elif area.isTransitionInteraction:
				$ThoughtBubble.animation = 'interaction'
		
		$ThoughtBubble.show()

func _on_Area2D_area_exited(area):
	activeArea = "";
	activeOutArea = "";
	global.next_scene = "";
	$ThoughtBubble.hide();


func _on_HUD_dialogFinished(id):
	global.setState("default")


func _on_Area2D_body_entered(body):
	if 'nodeType' in body:
		if body.nodeType == "damageNode":
			body.applyDamage()
			projectileDirection = body.movement
			$PlayerStateMachine.stagger()
			


func _on_StaggerTimer_timeout():
	$AnimatedSprite.modulate = Color(1, 1, 1)
	$PlayerStateMachine.setState(2)

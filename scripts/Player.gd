extends KinematicBody2D

const SPEED = 60;
const GRAVITY = 5;
const FLOOR = Vector2(0, -1);
export var health = 50;
var items = {};

var velocity = Vector2();
var insideDoor = false;
var activeArea;
var activeOutArea = "";
var isMenuOpen = false;

func _ready():
	velocity.y = GRAVITY
	HUD.connect("dialogFinished", self, "_on_HUD_dialogFinished")
	
#func _physics_process(delta):
#	velocity.y += GRAVITY
#	if global.getState() == "default":
#		if Input.is_action_pressed("ui_right"):
#			velocity.x = SPEED;
#			$AnimatedSprite.play("walk_right");
#		elif Input.is_action_pressed("ui_left"):
#			velocity.x = -SPEED;
#			$AnimatedSprite.play("walk_left");
#		else:
#			velocity.x = 0;
#			$AnimatedSprite.play("idle");
#
#		velocity = move_and_slide(velocity, FLOOR)
#	else:
#		$AnimatedSprite.play("idle")

func handleMovement(delta):
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
	
#	velocity = move_and_slide(velocity, Vector2(0, 0))
	
func applyMovement():
	move_and_slide(velocity, Vector2(0, 0))
#func _input(event):
#	if Input.is_action_just_pressed("ui_interact"):
#		print('items:', PlayerVariables.items)
#		if global.getState() == "default":
#			if (activeArea is Area2D):
#				if (activeArea.type == "Interactable_Object"):
#					print(activeArea.actionNeeded, activeArea.name)
#					if activeArea.transitionOnInteract && !activeArea.actionNeeded:
#						global.go_to_scene(activeArea.nextScene)
#					elif activeArea.transitionOnInteract && activeArea.actionNeeded:
#						HUD.showDialog(get_parent().name.to_lower(), activeArea.actionId)
#
#					# Open dialog		
#					elif activeArea.dialogId:
#						HUD.showDialog(get_parent().name.to_lower(), activeArea.dialogId)
#	#				else:
#	#					# Progress dialog
#	#					get_parent().get_node("HUD").loadDialog()
#
#	if Input.is_action_pressed("ui_up"):		
#		if global.next_scene != "" && global.next_scene != null:
#			global.previous_scene = get_tree().get_current_scene().name;
#			global.go_to_scene(global.next_scene);
		
		

func get_node_from_current_scene(nodeName):
	return 	get_tree().get_current_scene().get_node(nodeName)

func dialog_open(dialogContent):
	print(dialogContent)

func getStateMachine():
	return $PlayerStateMachine
	
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

extends KinematicBody2D

const SPEED = 60;
const GRAVITY = 5;
const FLOOR = Vector2(0, -1);
export var health = 50;
var items = {};

onready var exclamationBox = get_node("exclamation_box");

var velocity = Vector2();
var insideDoor = false;
var activeArea;
var activeOutArea = "";
var isMenuOpen = false;

func _ready():
	velocity.y = GRAVITY
func _physics_process(delta):
	velocity.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED;
		$AnimatedSprite.play("walk_right");
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED;
		$AnimatedSprite.play("walk_left");
	else:
		velocity.x = 0;
		$AnimatedSprite.play("idle");
				
	velocity = move_and_slide(velocity, FLOOR)
	
func _input(event):
	if Input.is_action_pressed("ui_interact"):
		if (activeArea is Area2D):
			if (activeArea.type == "Interactable_Object"):
				print(activeArea)
				if activeArea.transitionOnInteract:
					global.go_to_scene(activeArea.nextScene)
				# Open dialog		
				if activeArea.dialogId && !global.isDialogOpen:
					get_parent().get_node("HUD").showDialog(get_parent().name.to_lower(), activeArea.dialogId)
				else:
					# Progress dialog
					get_parent().get_node("HUD").loadDialog()
			
	if Input.is_action_pressed("ui_up"):		
		if global.next_scene != "" && global.next_scene != null:
			global.previous_scene = get_tree().get_current_scene().name;
			global.go_to_scene(global.next_scene);
		
		

func get_node_from_current_scene(nodeName):
	return 	get_tree().get_current_scene().get_node(nodeName)


func dialog_open(dialogContent):
	print(dialogContent)
	
func _on_Area2D_area_entered(area):
	print('entered', area)
	# First check if Area2d is a Portal or an Interactable Object
	activeArea = area;
	if area.type == "Portal":
		global.next_scene = area.get("nextScene");
	elif area.type == "Interactable_Object":
		exclamationBox.show();

func _on_Area2D_area_exited(area):
	activeArea = "";
	activeOutArea = "";
	global.next_scene = "";
	
	exclamationBox.hide();

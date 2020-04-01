extends Node2D

var activeArea;
var moveArm = false;
var moveBack = false;
var positionToMove;
var velocity = Vector2();
const hidePosition = Vector2(330, 1210);


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _process(delta):
	if moveArm:
		# More shitty code
		velocity = (positionToMove - $KinematicBody2D.get_global_position()).normalized() * 200;
		#var newPosition = $Arm.get_global_position() + Vector2(1,1);
		if (positionToMove - $KinematicBody2D.get_global_position()).length() > 5:
				velocity = $KinematicBody2D.move_and_slide(velocity)
		else:
			moveArm = false;
			# Start timer to move arm back
			$ArmBackTimer.start();
	if moveBack:
		$YellowBorder.visible = false;
		takeItemAndMove();
	
func _input(event):
	if Input.is_action_just_pressed("ui_interact"):
		$Dialogbox.loadDialog()
		
func takeItemAndMove():
	velocity = (hidePosition - $KinematicBody2D.get_global_position()).normalized() * 200;
	if (hidePosition - $KinematicBody2D.get_global_position()).length() > 5:
		velocity = $KinematicBody2D.move_and_slide(velocity)
		$ShroomPack.set_position($KinematicBody2D.get_global_position() + Vector2(-350, -160))
	else:
		moveBack = false;
		$ShroomPack.queue_free();
		addItemToInventory($ShroomPack.name);

func addItemToInventory(item):
	PlayerVariables.items.append(item);
	
func _on_ArmBackTimer_timeout():
	moveBack = true;

func _on_Area2D_mouse_entered():
	$YellowBorder.visible = true;

func _on_Area2D_mouse_exited():
	$YellowBorder.visible = false;

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		positionToMove = event.get_global_position();
		moveArm = true;

func _on_GoBackButton_pressed():
	global.previous_scene = "desk"
	global.go_to_scene($GoBackButton.nextScene);

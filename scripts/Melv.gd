extends KinematicBody2D

const SPEED = 40
var velocity = Vector2.ZERO
var orbVelocity = Vector2.ZERO
var playerPosition = Vector2.ZERO
var startMoving = false
var moveOutPosition = Vector2.ZERO
var moveOut = false
onready var orb = $Orb
onready var melvTween = $MelvTween

signal rotationFinished


func _physics_process(delta):
	if startMoving:
		velocity = (playerPosition - self.position).normalized() * SPEED
		move_and_slide(velocity)
		
		if (playerPosition - self.position).length() < 20:
			startMoving = false
			action()
			
	if moveOut:
		velocity = (moveOutPosition - self.position).normalized() * SPEED
		move_and_slide(velocity)

func moveTowardsPlayer() -> void:
	playerPosition = get_tree().current_scene.get_node("Player").get_global_position()
	playerPosition.y -= 40
	startMoving = true

func moveOut(positionToMove : Vector2) -> void:
	print('positionToMove:', positionToMove)
	moveOutPosition = positionToMove
	moveOut = true

func action() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	HUD.showDialog("basement", "melv")

func givePowers() -> void:
	rotateMelv()

func rotateMelv() -> void:
	melvTween.interpolate_property(self, "rotation_degrees", self.rotation_degrees, 0, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.2)
	melvTween.start()
	
func _on_OrbTween_tween_completed(object, key):
	emit_signal("rotationFinished")
	orb.get_node("Particles2D").emitting = true
	

func _on_MelvTween_tween_all_completed():
	emit_signal("rotationFinished")


func _on_VisibilityNotifier2D_screen_exited():
	hide()
	moveOut = false

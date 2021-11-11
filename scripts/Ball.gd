extends KinematicBody2D

var velocity = Vector2.ZERO
const SPEED = 20
var direction = "right"
var multiplier = 1


func _process(delta):
	if direction < 0:
		multiplier = -1
	velocity = move_and_slide(Vector2(10 * multiplier, 0) * SPEED) 


func _on_DestroyTimer_timeout() -> void:
	queue_free()

func setPosition(objDirection) -> void:
	if objDirection < 0:
		multiplier = -1
	position.x = 20 * multiplier

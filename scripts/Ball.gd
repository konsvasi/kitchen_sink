extends KinematicBody2D

var velocity = Vector2.ZERO
const SPEED = 20
var direction = "right"
var multiplier = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	print('direction:', direction)
	if direction < 0:
		multiplier = -1
	velocity = move_and_slide(Vector2(10 * multiplier, 0) * SPEED) 


func _on_DestroyTimer_timeout():
	queue_free()

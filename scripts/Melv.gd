extends KinematicBody2D

var velocity = Vector2.ZERO
var playerPosition = Vector2.ZERO
var startMoving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if startMoving:
		velocity = (playerPosition - self.position).normalized() * 40
		move_and_slide(velocity)
		
		if (playerPosition - self.position).length() < 20:
			startMoving = false

func moveTowardsPlayer() -> void:
	playerPosition = get_tree().current_scene.get_node("Player").get_global_position()
	playerPosition.y -= 40
	startMoving = true
	

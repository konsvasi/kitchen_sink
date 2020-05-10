extends KinematicBody2D

var nodeType = "damageNode"
var velocity = Vector2()
var damage = 5
var angle
var movement

func _ready():
	velocity.x = -80
	$AnimationPlayer.play("move")


func _physics_process(delta):
	movement = move_and_collide(velocity * delta)

func applyDamage():
	destroy()
	return damage

func destroy():
	# maybe add some animation before freeing asset
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

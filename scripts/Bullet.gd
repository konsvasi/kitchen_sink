extends KinematicBody2D

var bodyName = "projectile"
var nodeType = "damageNode"
var velocity = Vector2.ZERO
var testvelocity = Vector2.ZERO
var damage = 5
var angle
var movement
var explosion = preload("res://scenes/Explosion.tscn")

func _ready():
#	velocity.x = -80
	var target = get_tree().current_scene.get_node("Player").get_global_position()
	velocity = (target - self.get_global_position()).normalized() * 80
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


func _on_Area2D_body_entered(body):
	if (body.name == "Ball"):
		body.queue_free()
		velocity = Vector2.ZERO
		$Sprite.hide()
		add_child(explosion.instance())
		yield(get_tree().create_timer(1.2), "timeout")
		queue_free()
		print('play explosion queue_free both')

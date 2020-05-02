extends KinematicBody2D

var nodeType = "damageNode"
var damage = 20
signal attackFinished
signal reachedStartPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func applyDamage():
	emit_signal("attackFinished", "trample")
	return damage


func _on_Area2D_body_entered(body):
	print('hit floor', body)
	if body is StaticBody2D:
		emit_signal("attackFinished", "trample")

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



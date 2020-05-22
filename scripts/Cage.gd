extends Sprite

var nodeType = "damageNode"
const DAMAGE = 15
signal attackFinished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func applyDamage():
	emit_signal("attackFinished", "cage")
	return DAMAGE

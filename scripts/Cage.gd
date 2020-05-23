extends Sprite

var nodeType = "damageNode"
onready var cageArea = $CageArea
const DAMAGE = 15
signal attackFinished

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().current_scene.get_node("Player")
	player.connect("attack_blocked", self, "_on_attack_blocked")

func applyDamage():	
	return DAMAGE

func checkOverlap():
	return cageArea.overlaps_body(get_tree().current_scene.get_node("Player"))

func moveToStart():
	position = Vector2.ZERO

func finishAttack():
	yield(get_tree().create_timer(2.0), "timeout")
	emit_signal("attackFinished", "cage")

func _on_attack_blocked(attack):
	finishAttack()

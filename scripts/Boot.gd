extends KinematicBody2D

var nodeType = "damageNode"
const DAMAGE = 90
var isDemo = false
signal attackFinished
signal reachedStartPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func applyDamage():
	emit_signal("attackFinished", "trample")
	return DAMAGE


func _on_Area2D_body_entered(body):
	if body is StaticBody2D:
		emit_signal("attackFinished", "trample")


func _on_VisibilityNotifier2D_screen_exited():
	hide()
	if isDemo:
		var villain = get_tree().get_nodes_in_group('villain')[0]
		villain.get_node('VillainStateMachine').canAttack = false
		villain.setState(4)
		# set state to something new like states.cutscene where villain is inactive
		print('setState idle', get_tree().get_nodes_in_group('villain'), ' scene', get_tree().current_scene)
		isDemo = false


func _on_VisibilityNotifier2D_screen_entered():
	show()

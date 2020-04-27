extends Node2D

var speed = 10
var velocity = Vector2()
const FLOOR = Vector2(0, -1);
var positionToGo

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property($NameContainer.get_material(), "shader_param/amount", 1.0, 0.0, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()


func _process(delta):
	if $Position.get_global_position().x - $Character.get_global_position().x > 0.01:
		positionToGo = $Position.get_global_position().x
#	else:
#		print('slow')
#		positionToGo = $PositionSlow.get_global_position().x
#		speed = 1
	velocity.x = (positionToGo - $Character.get_global_position().x) * speed
		
	velocity = $Character.move_and_slide(velocity, FLOOR)
	
	
func _on_Tween_tween_completed(object, key):
	$Alert.play()


func _on_Alert_finished():
	$Alert.stop()
	yield(get_tree().create_timer(1.0), "timeout")
	global.go_to_sceneNew("basement")

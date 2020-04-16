extends Node2D

const SPEED = 10
var velocity = Vector2()
const FLOOR = Vector2(0, -1);

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property($NameContainer.get_material(), "shader_param/amount", 1.0, 0.0, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = ($Position.get_global_position().x - $Character.get_global_position().x) * SPEED
	
	velocity = $Character.move_and_slide(velocity, FLOOR)
	


func _on_Tween_tween_completed(object, key):
	print('play')
	$Alert.play()


func _on_Alert_finished():
	$Alert.stop()

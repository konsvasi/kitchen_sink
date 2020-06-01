extends CanvasLayer

onready var animationPlayer = $AnimationPlayer
onready var fader = $Control/Fader
signal scene_changed

func change_scene(path, delay=0.3) -> void:
	print('current', get_tree().get_current_scene().get_name())
	global.previous_scene = get_tree().get_current_scene().get_name().to_lower()
	yield(get_tree().create_timer(delay), "timeout")
	animationPlayer.play("fade")
	yield(animationPlayer, "animation_finished")
	var formattedPath = "res://Scenes/" + path + ".tscn"
	assert(get_tree().change_scene(formattedPath) == OK)
	animationPlayer.play_backwards("fade")
	yield(animationPlayer, "animation_finished")
	emit_signal('scene_changed')
	# what if the emit_signal has two arguments, next scene and previous scene
	# so instead of using get_tree().get_current_scene.get_name()
	# I'll just use the global that I've set from the signal
	

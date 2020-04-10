extends TextureRect

var hue_timer = 0
var speed = 160 #degrees per second
var colorEyes = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if colorEyes:
		hue_timer = fmod(hue_timer + delta * speed, 360)
		var h = hue_timer / 360 #h,s,v needs to be in range 0-1
	
		#New color, the order MUST be set in V,S,H, this is because Color
		#only saves RGB values, it does not save HSV values.
		var new_color = Color()
		new_color.v = 1 #value
		new_color.s = 1 #saturation
		new_color.h = h #hue
	
		get_node("EyeLeft").set_modulate(new_color)
		get_node("EyeRight").set_modulate(new_color)

func stretchEyes():
	$EyeTween.interpolate_property($EyeLeft, "rect_size", Vector2(64,35), Vector2(63, 280), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$EyeTween.interpolate_property($EyeRight, "rect_size", Vector2(64,35), Vector2(63, 280), 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$EyeTween.start()

func _on_EyeTimer_timeout():
	print('time out')
	colorEyes = true
	stretchEyes()

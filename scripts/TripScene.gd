extends TextureRect

var hue_timer = 0
var speed = 160 #degrees per second
var colorEyes = false
var firstTime = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Terry.modulate.a = 0
	$HUD.disableMenu()

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
	$HUD.showDialog("trip", "main")
	

func _on_HUD_dialogFinished(dialogId):
	if dialogId == "main":
		$Terry/TerryTween.interpolate_property($Terry, 'modulate', Color(1, 1, 1, 0), Color(1, 1, 1, 1), 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Terry/TerryTween.start()
		firstTime = true
	
	if dialogId == "take_it_easy":
		yield(get_tree().create_timer(1.0), "timeout")
		firstTime = false
		$Terry/TerryTween.interpolate_property($Terry, 'modulate', Color(1, 1, 1, 1), Color(1, 1, 1, 0), 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Terry/TerryTween.start()


func _on_TerryTween_tween_completed(object, key):
	if firstTime:
		$HUD.showDialog("trip", "take_it_easy")

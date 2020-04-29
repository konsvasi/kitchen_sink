extends Node2D

var velocity
var tween

func _ready():
	pass # Replace with function body.



func moveOnPath(pathToFollow : PathFollow2D) -> void:
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(pathToFollow, "unit_offset", 0, 1, 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

extends Node2D

var isMoving = false
var positionToMove
var velocity
var tween

func _ready():
	pass # Replace with function body.


#func _process(delta):
#	if isMoving:
#		print('moving')
#		velocity = (positionToMove - $KinematicBody2D.get_global_position()).normalized() * 200;
#
#		if (positionToMove - $KinematicBody2D.get_global_position()).length() > 5:
#				velocity = $KinematicBody2D.move_and_slide(velocity)
#		else:
#			isMoving = false
		
# start tween with pathtofollow2d stuff
# don't use _process delta to move stuff around
func moveOnPath(pathToFollow : PathFollow2D) -> void:
#	isMoving = true
#	positionToMove = position
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(pathToFollow, "unit_offset", 0, 1, 7, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

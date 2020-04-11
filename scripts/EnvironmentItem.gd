extends Node2D

signal grabItemByPosition
signal grabItemById

export var grabById = true
export var grabByPosition = false
export(String) var id

func _ready():
	$ItemWithShader.texture = self.texture
	# Has to be fixed
	$ItemWithShader/Area2D/CollisionRect.shape.extents = self.texture.get_size() / 4

func _on_Area2D_mouse_entered():
	$ItemWithShader.show()

func _on_Area2D_mouse_exited():
	$ItemWithShader.hide()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print(event)
		if grabById:
			emit_signal('grabItemById', id)
		else:
			emit_signal("grabItemByPosition", global_position)

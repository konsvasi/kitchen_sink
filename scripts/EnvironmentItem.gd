extends Node2D

func _ready():
	$ItemWithShader.texture = self.texture
	# Has to be fixed
	$ItemWithShader/Area2D/CollisionRect.shape.extents = self.texture.get_size() / 4

func _on_Area2D_mouse_entered():
	$ItemWithShader.show()


func _on_Area2D_mouse_exited():
	$ItemWithShader.hide()

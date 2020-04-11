extends Area2D;

var id = "mouse"
# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	self.position = get_global_mouse_position();
	$Sprite.position = get_global_mouse_position();
	$CollisionShape2D.position = $Sprite.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = get_global_mouse_position();
	$Sprite.position = self.position
	$CollisionShape2D.position = $Sprite.position

func _on_Area2D_area_entered(area):
	print("Enterino", area.name)

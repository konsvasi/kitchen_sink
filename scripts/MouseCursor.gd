extends Area2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	self.position = get_global_mouse_position();
	$Sprite.position = get_global_mouse_position();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
	self.position = get_global_mouse_position();
	$Sprite.position = self.position

func _on_Area2D_area_entered(area):
	print("Enterino", area.name)

extends Polygon2D

var opacity : int = 0;
export var dialogText : String = "";
# Called when the node enters the scene tree for the first time.
func _ready():
	# Add some kind of nice transition
	# for first time opening the dialogbox
	$RichTextLabel.bbcode_text = dialogText;

func _on_Timer_timeout():
	self.visible = true;

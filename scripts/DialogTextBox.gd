extends RichTextLabel

var dialog = ["Hello from dialogbox!"]

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialog[0])


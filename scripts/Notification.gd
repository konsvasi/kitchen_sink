extends Control


var notificationId

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setText(id):
	$Label.set_text(DialogContent.get_notification_content(id))

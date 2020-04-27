extends Control

var notificationId

func _ready():
	pass # Replace with function body.

func setText(id):
	$Label.set_text(DialogContent.get_notification_content(id))

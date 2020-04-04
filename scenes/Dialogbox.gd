extends Control

var dialog = ['default']
var index = 0

func _ready():
	loadDialog()

#func _process(delta):
#	pass

func setDialog(dialogArray):
	dialog = dialogArray
	index = 0
	loadDialog()
	
func loadDialog():
	if index == dialog.size():
		hide()
		global.isDialogOpen = false

	if index < dialog.size():
		$RichTextLabel.bbcode_text = dialog[index]
		$Tween.interpolate_property($RichTextLabel,
			'percent_visible',
			0,1,1,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
		$Tween.start()
		
	index += 1
	
	if index == dialog.size():
		$Arrow.hide()
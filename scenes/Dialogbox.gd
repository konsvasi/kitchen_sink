extends Control

var dialog = [
	'Hello there',
	'This is a dialog',
	'Have fun'
]

var index = 0

func _ready():
	loadDialog()

#func _process(delta):
#	pass

func loadDialog():
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
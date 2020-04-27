extends Control

signal dialogFinished
var dialog = ['default']
var index = 0
var dialogId

func _ready():
	pass
#	loadDialog()

func setDialog(dialogArray, dialogId):
	dialog = dialogArray
	self.dialogId = dialogId
	index = 0
	print('dialog', dialog[0])
	loadDialog()
	
func setId(id):
	dialogId = id

func loadDialog():
	print('idx: ', index, ' dialog.size: ', dialog.size())
	var emit = false
	if index == dialog.size():
		hide()
		global.isDialogOpen = false
		emit = true
#		index = -1

	elif index < dialog.size() && index >= 0:
		$RichTextLabel.bbcode_text = dialog[index]
		$Tween.interpolate_property($RichTextLabel,
			'percent_visible',
			0,1,1,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
		$Tween.start()
	
	index += 1
	if emit:
		emit_signal("dialogFinished", dialogId)

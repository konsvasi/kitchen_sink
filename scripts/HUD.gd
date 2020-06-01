extends CanvasLayer

signal dialogFinished
signal notificationClosed
var index = 0
var menuOptions = ['Inventory', 'Options']
var dialog = []
var menuDisabled = false
onready var dialogBox = $BottomDialogContainer/Dialogbox
onready var healthbar = $Healthbar
onready var villainHealthBar = $VillainHealthBar

func _ready():
	healthbar.setHealthBar(PlayerVariables.maxHealth, PlayerVariables.health)

func disableMenu():
	menuDisabled = true

func showNotification(notificationId):
	$Notification.setText(notificationId)
	$Notification.show()
	get_tree().paused = true

func updateHealth(amount, target="player"):
	if target == "villain":
		villainHealthBar.updateHealth(amount)
	else:
		healthbar.updateHealth(amount)
	
func _on_InventoryMenu_hide():
	pass
#	$InventoryMenu.clearItems()
#	self.set_process_unhandled_key_input(true)

func showDialog(currentScene, dialogId, position="down"):
	if position == "up":
		$BottomDialogContainer.remove_child(dialogBox)
		$TopDialogContainer.add_child(dialogBox)
		
		
	dialog = DialogContent.get_content(currentScene, dialogId)
	var name = DialogContent.get_dialog_owner(currentScene, dialogId)
	dialogBox.setDialog(dialog, dialogId, name)
	dialogBox.show()
	global.isDialogOpen = true
#	yield(get_tree().create_timer(0.1), "timeout")
	global.setState("dialog")

func loadDialog():
	dialogBox.loadDialog()

func isDialogOpen():
	return dialogBox.visible

func updateItems():
	$InventoryMenu.updateItems()

func showPlayerHealthbar() -> void:
	healthbar.show()
	
# Should be called when dialog was displayed in top position
func resetDialogPosition():
	$TopDialogContainer.remove_child(dialogBox)
	$BottomDialogContainer.add_child(dialogBox)
	
func _on_Dialogbox_dialogFinished(finishedDialogId):
#	global.setState("default")
	emit_signal("dialogFinished", finishedDialogId)

func setHealthBar (maxHealth, currentHealth, target="villain") -> void:
	print(maxHealth, currentHealth, target)
	if target == "villain":
		villainHealthBar.setHealthBar(maxHealth, currentHealth)

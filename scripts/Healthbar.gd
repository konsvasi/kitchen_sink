extends Control
onready var healthbar = $Healthbar
onready var updateTween = $UpdateTween

var healthyColor = Color.green
var cautionColor = Color.yellow
var dangerColor = Color.red

func updateHealth(amount) -> void:
	updateTween.interpolate_property(healthbar, "value", healthbar.value, healthbar.value - amount, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	updateTween.start()
	assignColor()

func assignColor() -> void:
	# Caution
	if PlayerVariables.health > PlayerVariables.health * 0.3 && PlayerVariables.health > PlayerVariables.health * 0.5:
		healthbar.tint_progress = dangerColor
	else:
		healthbar.tint_progress = healthyColor

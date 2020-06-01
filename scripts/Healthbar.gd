extends Control
onready var healthbar = $HealthbarOver
onready var healthbarUnder = $HealthbarUnder
onready var updateTween = $UpdateTween
onready var sound = $SoundEffects
export (String) var target
const targets = ["Player", "Villain"]

var healthyColor = Color.green
var cautionColor = Color.yellow
var dangerColor = Color.red

func _ready():
	if target == "Player":
		healthbar.max_value = PlayerVariables.maxHealth
		healthbar.value = PlayerVariables.health
		healthbarUnder.max_value = PlayerVariables.maxHealth
		healthbarUnder.value = PlayerVariables.health
	elif target == "Villain":
		healthbar.max_value = VillainVariables.maxHealth
		healthbar.value = VillainVariables.health
		healthbarUnder.max_value = VillainVariables.maxHealth
		healthbarUnder.value = VillainVariables.health
	
func updateHealth(amount) -> void:
	healthbar.value -= amount
#˚	updateTween.interpolate_property(healthbarUnder, "value", healthbarUnder.value, healthbarUnder.value - amount, 0.4,Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
#	updateTween.start()
#	healthbarUnder.value -= amount
#	assignColor()

func heal(amount) -> void:
	updateTween.interpolate_property(healthbar, "value", healthbar.value, healthbar.value + amount, 2.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	updateTween.start()
	sound.play()
	
func assignColor() -> void:
	# Caution
	if PlayerVariables.health > PlayerVariables.health * 0.3 && PlayerVariables.health > PlayerVariables.health * 0.5:
		healthbar.tint_progress = dangerColor
	else:
		healthbar.tint_progress = healthyColor

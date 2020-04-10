extends Control


onready var audioPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play(trackPath:String, volume:float=0.0) -> void:
	stop()
	var track = load(trackPath)
	audioPlayer.stream = track
	self.setVolume(volume)
	audioPlayer.play()

func stop() -> void:
	audioPlayer.stop()

func isPlaying() -> bool:
	return audioPlayer.playing

func setVolume(volume:float) -> void:
	audioPlayer.volume_db = volume

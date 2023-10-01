extends AudioStreamPlayer


export (float) var playback_volume = 0.0

func _ready():
	volume_db = -80.0

func mute():
	volume_db = -80.0

func unmute():
	volume_db = playback_volume

func fade_in(length: float = 2.0):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "volume_db", playback_volume, length)

func fade_out(length: float = 2.0):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "volume_db", -80.0, length)

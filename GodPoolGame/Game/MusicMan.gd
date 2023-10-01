extends Node

var times_shrunk: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	EventServices.dispatch().subscribe(EnterNextUniverseStateEvent.ID, self, "_on_universe_change_event")
	$DroneBass.unmute()

func update_music_state():
	match(times_shrunk):
		0:
			$DroneBass.fade_in()
		1:
			$Chordz.fade_in()
		2:
			$TwinkleSynth.fade_in(10)
		4:
			$DroneBass.fade_out()
			$TwinkleSynth.fade_out(5)
			$TenseBass.fade_in(0.5)

func _on_universe_change_event(event: Event):
	times_shrunk = times_shrunk + 1
	update_music_state()

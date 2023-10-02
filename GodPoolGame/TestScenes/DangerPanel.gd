extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var wave_sequencer = $WaveSequencer


# Called when the node enters the scene tree for the first time.
func _ready():
	wave_sequencer.connect("new_value", self, "_on_wave_sequencer_something")
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_change")

func _on_wave_sequencer_something(val: float):
	self.modulate.a = val
	var scale_mod = 0.8 + ((1 - val) * 0.2)
	self.scale = Vector2(scale_mod, scale_mod)


func _on_level_state_change(event: Event):
	var level_event := event as LevelStateChangeEvent
	if not level_event:
		return
		
	if level_event.state_id == ChaosTurnState.ID:
		visible = false
	elif level_event.state_id == PlayerTurnState.ID:
		visible = true

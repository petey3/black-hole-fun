extends Node
class_name LevelController
# Control / manage da level and whats going on in there

# States
# Set up board
# Introduction
# Turn Sequence
# -- Player Turn
# -- Chaos Turn
# -- (Repeats)


onready var state_machine = $StateMachine

func _ready():
	EventServices.dispatch().subscribe(ReloadedCurrentSceneEvent.ID, self, "_on_level_reload")
	EventServices.dispatch().subscribe(NextLevelEvent.ID, self, "_on_next_level_event")


func _on_level_reload(event: Event):
	state_machine.transition_to("SetupLevelState")


func _on_next_level_event(event: Event):
	state_machine.transition_to("SetupLevelState")

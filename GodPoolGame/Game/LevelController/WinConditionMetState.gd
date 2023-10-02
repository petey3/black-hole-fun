extends State
class_name WinConditionMetState

const ID = "state.win_condition"

func enter(properties := {}) -> void:
	print("Entered WON STATE")
	var level_state_event = LevelStateChangeEvent.new(ID, false)
	level_state_event.can_go_to_next_level = true
	EventServices.dispatch().broadcast(level_state_event)

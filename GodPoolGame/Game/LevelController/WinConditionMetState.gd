extends State
class_name WinConditionMetState

const ID = "state.win_condition"

func enter(properties := {}) -> void:
	print("Entered WON STATE")
	var level_state_event = LevelStateChangeEvent.new(ID, false)
	EventServices.dispatch().broadcast(level_state_event)

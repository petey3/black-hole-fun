extends State
class_name SetupLevelState

const ID = "state.setup_level"

func enter(properties := {}) -> void:
	print("Entered SETUP LEVEL STATE")
	var level_state_event = LevelStateChangeEvent.new(ID, false)
	EventServices.dispatch().broadcast(level_state_event)
	state_machine.transition_to("PlayerTurnState", properties)

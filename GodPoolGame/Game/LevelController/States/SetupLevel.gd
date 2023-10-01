extends State
class_name SetupLevelState

func enter(properties := {}) -> void:
	print("Entered SETUP LEVEL STATE")
	var level_state_event = LevelStateChangeEvent.new(false)
	EventServices.dispatch().broadcast(level_state_event)
	state_machine.transition_to("PlayerTurnState", properties)

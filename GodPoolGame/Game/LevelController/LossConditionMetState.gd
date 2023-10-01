extends State
class_name LossConditionMetState

const ID = "state.loss_condition"

func enter(properties := {}) -> void:
	print("Entered LOST STATE")
	var level_state_event = LevelStateChangeEvent.new(ID, false)
	EventServices.dispatch().broadcast(level_state_event)

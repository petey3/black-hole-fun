extends State
class_name ChaosTurnState

const ID = "state.chaos_turn"

func enter(properties := {}) -> void:
	print("Entered CHAOS TURN STATE")
	var level_state_event = LevelStateChangeEvent.new(ID, false)
	EventServices.dispatch().broadcast(level_state_event)
	
	var universe_state_event = EnterNextUniverseStateEvent.new()
	EventServices.dispatch().broadcast(universe_state_event)
	
	var inline_timer = InlineTimer.wait(self, 3)
	yield(inline_timer.timer, inline_timer.timeout)
	
	var celestial_bodies = get_tree().get_nodes_in_group(GodPoolGameConstants.GROUP_ID_CELESTIAL_BODY)
	
	if celestial_bodies.size() == 1:
		state_machine.transition_to("LossConditionMetState")
	else:
		state_machine.transition_to("PlayerTurnState")

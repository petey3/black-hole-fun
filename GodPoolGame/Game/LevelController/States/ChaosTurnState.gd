extends State
class_name ChaosTurnState

const ID = "state.chaos_turn"

func enter(properties := {}) -> void:
	print("Entered CHAOS TURN STATE")
		
	var intro_timer = InlineTimer.wait(self, 0.5)
	yield(intro_timer.timer, intro_timer.timeout)

	var level_state_event = LevelStateChangeEvent.new(ID, false)
	EventServices.dispatch().broadcast(level_state_event)
	
	var universe_state_event = EnterNextUniverseStateEvent.new()
	EventServices.dispatch().broadcast(universe_state_event)
	
	var inline_timer = InlineTimer.wait(self, 3)
	yield(inline_timer.timer, inline_timer.timeout)
	
	if GameplayServices.entities().are_all_live_planets_saved():
		state_machine.transition_to("WinConditionMetState")
	elif GameplayServices.entities().are_all_live_planets_lost():
		state_machine.transition_to("LossConditionMetState")
	else:
		state_machine.transition_to("PlayerTurnState")

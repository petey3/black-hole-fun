extends LevelControllerState
class_name ChaosTurnState

const ID = "state.chaos_turn"

func enter(properties := {}) -> void:
	.enter(properties)
	print("Entered CHAOS TURN STATE")
		
	var intro_timer = InlineTimer.wait(self, 0.5)
	yield(intro_timer.timer, intro_timer.timeout)

	var level_state_event = LevelStateChangeEvent.new(ID, false)
	EventServices.dispatch().broadcast(level_state_event)
	
	var universe_state_event = EnterNextUniverseStateEvent.new()
	EventServices.dispatch().broadcast(universe_state_event)
	
	var inline_timer = InlineTimer.wait(self, 3)
	yield(inline_timer.timer, inline_timer.timeout)
	
	if _did_player_win():
		state_machine.transition_to("WinConditionMetState")
	elif _did_player_lose():
		state_machine.transition_to("LossConditionMetState")
	else:
		state_machine.transition_to("PlayerTurnState")


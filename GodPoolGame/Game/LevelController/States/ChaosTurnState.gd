extends State
class_name ChaosTurnState

func enter(properties := {}) -> void:
	print("Entered CHAOS TURN STATE")
	var level_state_event = LevelStateChangeEvent.new(false)
	EventServices.dispatch().broadcast(level_state_event)
	
	var universe_state_event = EnterNextUniverseStateEvent.new()
	EventServices.dispatch().broadcast(universe_state_event)
	
	var inline_timer = InlineTimer.wait(self, 3)
	yield(inline_timer.timer, inline_timer.timeout)
	state_machine.transition_to("PlayerTurnState")

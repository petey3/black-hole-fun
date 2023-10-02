extends State
class_name LevelControllerState


func _ready():
	EventServices.dispatch().subscribe(PlanetChangeEvent.ID, self, "_on_planet_change_event")


func _did_player_win() -> bool:
	if GameplayServices.entities().are_all_live_planets_saved():
		return true
		
	# Otherwise, if there are no planets left but we saved some
	# thats also a win
	var are_no_planets_left = GameplayServices.entities().total_remaining_planet_count() == 0
	var were_some_saved = GameplayServices.entities().saved_live_planets() > 0
	if are_no_planets_left and were_some_saved:
		return true
	
	return false
	

func _did_player_lose() -> bool:
	var were_all_live_planets_lost = GameplayServices.entities().are_all_live_planets_lost()
	return were_all_live_planets_lost
	
	
func _on_planet_change_event(event: Event):
	if not is_in_state:
		return
	
	print("PLANET CHANGE")
	var inline_timer = InlineTimer.wait(self, 0.5)
	yield(inline_timer.timer, inline_timer.timeout)
	
	# extra one in case things have changed with the yield
	if not is_in_state:
		return
	
	# check for a deterministic win or loss state
	if _did_player_win():
		state_machine.transition_to("WinConditionMetState")
	elif _did_player_lose():
		state_machine.transition_to("LossConditionMetState")

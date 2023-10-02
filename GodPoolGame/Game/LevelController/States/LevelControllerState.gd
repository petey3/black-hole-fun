extends State
class_name LevelControllerState

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
	

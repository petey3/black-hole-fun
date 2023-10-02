extends State
class_name PlayerTurnState

const ID = "state.player_turn"

var has_player_shot = false
var has_triggered_first_frame = false

func _ready():
	EventServices.dispatch().subscribe(PlayerShot.ID, self, "_on_player_shot")

func enter(properties := {}) -> void:
	print("Entered PLAYER TURN STATE")
	has_player_shot = false
	var level_state_event = LevelStateChangeEvent.new(ID, true)
	EventServices.dispatch().broadcast(level_state_event)
	
	
func physics_update(delta):
	if not has_player_shot:
		return
	
	var celestial_bodies = get_tree().get_nodes_in_group(GodPoolGameConstants.GROUP_ID_CELESTIAL_BODY)
	
	# return if bodies are still moving
	if GameplayServices.entities().are_bodies_still_moving():
		return
		
	if _did_player_win():
		state_machine.transition_to("WinConditionMetState")
		return
	elif _did_player_lose():
		state_machine.transition_to("LossConditionMetState")
		return
	
	has_player_shot = false
	state_machine.transition_to("ChaosTurnState")


func _on_player_shot(event: Event):
	var inline_timer = InlineTimer.wait(self, 1)
	yield(inline_timer.timer, inline_timer.timeout)
	has_player_shot = true
	
	
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
	return GameplayServices.entities().are_all_live_planets_lost()
	


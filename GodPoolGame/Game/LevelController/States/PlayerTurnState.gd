extends State
class_name PlayerTurnState

const ID = "state.player_turn"

var has_player_shot = false
var has_triggered_first_frame = false

func _ready():
	EventServices.dispatch().subscribe(PlayerShot.ID, self, "_on_player_shot")

func enter(properties := {}) -> void:
	print("Entered PLAYER TURN STATE")
	print("TODO: Update New Universe Line")
	var level_state_event = LevelStateChangeEvent.new(ID, true)
	EventServices.dispatch().broadcast(level_state_event)
	
	
func update(delta):
	if has_triggered_first_frame:
		return
		
	GameplayServices.entities().create_level_info()
	has_triggered_first_frame = true
	
	
func physics_update(delta):
	if not has_player_shot:
		return
	
	var celestial_bodies = get_tree().get_nodes_in_group(GodPoolGameConstants.GROUP_ID_CELESTIAL_BODY)
	
	# return if bodies are still moving
	if GameplayServices.entities().are_bodies_still_moving():
		return
		
	if GameplayServices.entities().are_all_live_planets_saved():
		state_machine.transition_to("WinConditionMetState")
	elif GameplayServices.entities().are_all_live_planets_lost():
		state_machine.transition_to("LossConditionMetState")
	
	has_player_shot = false
	state_machine.transition_to("ChaosTurnState")


func _on_player_shot(event: Event):
	var inline_timer = InlineTimer.wait(self, 1)
	yield(inline_timer.timer, inline_timer.timeout)
	has_player_shot = true

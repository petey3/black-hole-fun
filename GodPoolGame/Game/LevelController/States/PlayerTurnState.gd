extends State
class_name PlayerTurnState

const ID = "state.player_turn"

var has_player_shot = false

func _ready():
	EventServices.dispatch().subscribe(PlayerShot.ID, self, "_on_player_shot")

func enter(properties := {}) -> void:
	print("Entered PLAYER TURN STATE")
	print("TODO: Update New Universe Line")
	var level_state_event = LevelStateChangeEvent.new(ID, true)
	EventServices.dispatch().broadcast(level_state_event)
	
	
func physics_update(delta):
	if not has_player_shot:
		return
	
	var celestial_bodies = get_tree().get_nodes_in_group(GodPoolGameConstants.GROUP_ID_CELESTIAL_BODY)
	
	if celestial_bodies.size() == 1:
		state_machine.transition_to("LossConditionMetState")
	
	for body in celestial_bodies:
		var rigid_body := body as RigidBody2D
		if not rigid_body:
			continue
			
		if rigid_body.linear_velocity.length() > 0:
			return
		
	has_player_shot = false
	state_machine.transition_to("ChaosTurnState")


func _on_player_shot(event: Event):
	var inline_timer = InlineTimer.wait(self, 1)
	yield(inline_timer.timer, inline_timer.timeout)
	has_player_shot = true

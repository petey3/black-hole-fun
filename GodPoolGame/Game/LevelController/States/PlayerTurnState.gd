extends State
class_name PlayerTurnState

var has_player_shot = false

func _ready():
	EventServices.dispatch().subscribe(PlayerShot.ID, self, "_on_player_shot")

func enter(properties := {}) -> void:
	print("Entered PLAYER TURN STATE")
	print("TODO: Update New Universe Line")
	var level_state_event = LevelStateChangeEvent.new(true)
	EventServices.dispatch().broadcast(level_state_event)
	
	
func physics_update(delta):
	if not has_player_shot:
		return
	
	var balls = get_tree().get_nodes_in_group('Balls')
	for ball in balls:
		var rigid_ball := ball as RigidBody2D
		if not rigid_ball:
			continue
			
		if rigid_ball.linear_velocity.length() > 0:
			return
		
	has_player_shot = false
	state_machine.transition_to("ChaosTurnState")


func _on_player_shot(event: Event):
	var inline_timer = InlineTimer.wait(self, 1)
	yield(inline_timer.timer, inline_timer.timeout)
	has_player_shot = true

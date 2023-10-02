extends Event
class_name LevelStateChangeEvent

const ID = "events.level_state_change"

var state_id: String
var is_player_in_control: bool
var can_go_to_next_level = false

func _init(state_id: String, player_control: bool).(ID):
	self.state_id = state_id
	self.is_player_in_control = player_control

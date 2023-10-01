extends Event
class_name LevelStateChangeEvent

const ID = "events.level_state_change"

var state_id: String
var is_player_in_control: bool

func _init(state_id: String, player_control: bool).(ID):
	self.state_id = state_id
	self.is_player_in_control = player_control

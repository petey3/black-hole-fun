extends Event
class_name LevelStateChangeEvent

const ID = "events.level_state_change"

var is_player_in_control: bool

func _init(player_control: bool).(ID):
	self.is_player_in_control = player_control

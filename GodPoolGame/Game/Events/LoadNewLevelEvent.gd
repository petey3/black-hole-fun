extends Event
class_name LoadNewLevelEvent

const ID = "event.load_new_level"

var level_to_load: int

func _init(level_to_load: int).(ID):
	print('nnnnnnnnnnnnn')
	self.level_to_load = level_to_load

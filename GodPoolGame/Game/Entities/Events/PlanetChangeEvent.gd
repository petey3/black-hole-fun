extends Event
class_name PlanetChangeEvent

const ID = "event.planet_change_event"

enum ChangeType { VOID, BLACKHOLE, WHITEHOLE }

var change_type
var population

func _init(change_type: int, population: int).(ID):
	self.change_type = change_type
	self.population = population

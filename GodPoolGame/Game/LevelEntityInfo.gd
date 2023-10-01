extends Object
class_name LevelEntityInfo

var starting_live_planet_count
var starting_dead_planet_count
var saved_live_planet_count
var lost_live_planet_count

func _init(starting_live: int, starting_dead: int):
	self.starting_live_planet_count = starting_live
	self.starting_dead_planet_count = starting_dead
	self.saved_live_planet_count = 0
	self.lost_live_planet_count = 0

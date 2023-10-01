extends CelestialBody
class_name Planet

export (int) var population = 0

func has_life() -> bool:
	return population > 0


func _add_to_groups():
	._add_to_groups()
	add_to_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_SWALLOWABLE)

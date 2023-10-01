extends CelestialBody
class_name Planet

export (int) var population = 0

func has_life() -> bool:
	return population > 0


func _add_to_groups():
	._add_to_groups()
	add_to_group(GodPoolGameConstants.GROUP_ID_PLANET)
	add_to_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_SWALLOWABLE)
	add_to_group(GodPoolGameConstants.GROUP_ID_VOID_SWALLOWABLE)
	add_to_group(GodPoolGameConstants.GROUP_ID_WHITE_HOLE_CAPTURABLE)


func _on_void_destroy():
	var void_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.VOID, population)
	EventServices.dispatch().broadcast(void_event)
	._on_void_destroy()


func _on_swallowed_by_blackhole():
	var blackhole_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.BLACKHOLE, population)
	EventServices.dispatch().broadcast(blackhole_event)
	._on_swallowed_by_blackhole()


func _on_collide_with_whitehole():
	var whitehole_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.WHITEHOLE, population)
	EventServices.dispatch().broadcast(whitehole_event)
	._on_collide_with_whitehole()

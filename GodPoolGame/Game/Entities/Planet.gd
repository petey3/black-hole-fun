extends CelestialBody
class_name Planet

export (int) var population = 0

func has_life() -> bool:
	return population > 0

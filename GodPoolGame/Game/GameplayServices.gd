extends Node
# GameplayServices

onready var entity_services = $EntityServices

func entities() -> EntityServices:
	return entity_services

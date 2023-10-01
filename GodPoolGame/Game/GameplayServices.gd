extends Node
# GameplayServices

onready var entity_services = $EntityServices
onready var level_services = $LevelServices

func entities() -> EntityServices:
	return entity_services
	

func levels() -> LevelServices:
	return level_services

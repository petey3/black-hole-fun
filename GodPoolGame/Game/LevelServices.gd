extends Node
class_name LevelServices

func reload_current_scene():
	# get_tree().reload_current_scene()
	
	var reload_event = ReloadedCurrentSceneEvent.new()
	EventServices.dispatch().broadcast(reload_event)

func load_level(level_to_load: int):
	var new_level_event = LoadNewLevelEvent.new(level_to_load)
	EventServices.dispatch().broadcast(new_level_event)

func next_level():
	var next_level_event = NextLevelEvent.new()
	EventServices.dispatch().broadcast(next_level_event)

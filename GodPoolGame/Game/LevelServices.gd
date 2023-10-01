extends Node
class_name LevelServices

func reload_current_scene():
	get_tree().reload_current_scene()
	var reload_event = ReloadedCurrentSceneEvent.new()
	EventServices.dispatch().broadcast(reload_event)

extends Node2D

var level_list: Array = [
	preload("res://GodPoolGame/Game/Levels/Level 1.tscn"),
	preload("res://GodPoolGame/Game/Levels/Level 2.tscn"),
	preload("res://GodPoolGame/Game/Levels/Level 3.tscn"),
	preload("res://GodPoolGame/Game/Levels/Level 4.tscn"),
	preload("res://GodPoolGame/Game/Levels/Level 5.tscn"),
	preload("res://GodPoolGame/Game/Levels/ThankYouLevel.tscn"),
] 

var current_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_level(current_level)
	
	EventServices.dispatch().subscribe(ReloadedCurrentSceneEvent.ID, self, "_on_reload_scene_event")
	EventServices.dispatch().subscribe(LoadNewLevelEvent.ID, self, "_on_new_level_event")
	EventServices.dispatch().subscribe(NextLevelEvent.ID, self, "_on_next_level_event")


func _load_level(level_to_load):
	if level_to_load + 1 > level_list.size():
		level_to_load =  0
	
	current_level = level_to_load
	
	for n in get_children():
		n.queue_free()
	
	var new_level = level_list[level_to_load].instance()
	add_child(new_level)
	

func _on_reload_scene_event(event: Event):
	_load_level(current_level)


func _on_new_level_event(event: Event):
	var new_level_event := event as LoadNewLevelEvent
	var level_to_load = new_level_event.level_to_load
	
	_load_level(level_to_load)


func _on_next_level_event(event):
	_load_level(current_level+1)

extends Node2D
class_name Level

var level_entity_info = null
var has_run_first_frame = false

func _process(delta):
	if not has_run_first_frame:
		GameplayServices.entities().register_current_level(self)
		has_run_first_frame = true

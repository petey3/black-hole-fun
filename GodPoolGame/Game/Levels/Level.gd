extends Node2D
class_name Level

var level_entity_info = null

func _ready():
	GameplayServices.entities().register_current_level(self)

extends Node2D
class_name Gameplay_Context_World

onready var level_root = $LevelRoot

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		GameplayServices.levels().reload_current_scene()

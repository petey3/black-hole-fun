extends Node2D
class_name Gameplay_Context_World

onready var level_root = $LevelRoot

func _input(event):
	if event is InputEventKey:
		var just_pressed = event.is_pressed() and not event.is_echo()
		if just_pressed and event.scancode == KEY_R:
			GameplayServices.levels().reload_current_scene()

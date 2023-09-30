extends Node
class_name DirectionCalculator2D

signal direction_changed(old_direction, new_direction)

export (float, 0.0, 1.0) var direction_change_responsiveness = 0.5

func get_current_direction() -> Vector2:
	# Subclasses should provide 
	# their own calculation
	return Vector2.ZERO
	
	
func update_direction(old_direction, new_direction):
	emit_signal("direction_changed", old_direction, new_direction)


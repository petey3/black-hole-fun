extends Node
class_name SpeedCalculator

signal speed_changed(old_speed, new_speed)

export (float) var top_speed
export (bool) var has_acceleration
export (float) var acceleration
export (float) var deacceleration

var current_speed = 0.0

func get_current_speed() -> float:
	# Subclasses should provide 
	# their own calculation
	return current_speed
	

func update_speed(old_speed, new_speed):
	emit_signal("speed_changed", old_speed, new_speed)

extends Node
class_name SpinStopCalculator

signal update_spinning_value(should_spin)

var total_time_spun = 0.0
var current_rotation_degrees = 0.0
var total_degrees_rotated = 0.0
var number_of_full_rotations = 0

var delegate = null

func update(delta: float, current_is_spinning: bool, current_rotation: float, rotation_delta: float):
	total_time_spun += delta
	current_rotation_degrees = current_rotation
	total_degrees_rotated += rotation_delta
	number_of_full_rotations = abs(total_degrees_rotated / 360.0)
	
	var should_spin = get_should_spin_value(current_is_spinning, total_time_spun, current_rotation_degrees, total_degrees_rotated, number_of_full_rotations)
	if should_spin != current_is_spinning:
		emit_signal("update_spinning_value", should_spin)
	

func get_should_spin_value(current_is_spinning, total_time_spun, current_rotation_degrees, total_degrees_rotated, number_of_full_rotations) -> bool:
	# Subclasses should override
	# Maybe use delegate instead?
	if delegate:
		return delegate.get_should_spin_value(current_is_spinning, total_time_spun, current_rotation_degrees, total_degrees_rotated, number_of_full_rotations)
	return true


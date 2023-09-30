extends TweenFeedback2D
class_name BaseTweenTransformFeedback2D

enum ChangeMode {DISCRETE, STACK}
enum ValueMode {ABSOLUTE, ADDITIVE, MULTIPLICATIVE}

export (ChangeMode) var change_mode
export (ValueMode) var value_mode

func _get_starting_value(original_value, current_value):
	return _get_starting_value_with_modes(change_mode, value_mode, original_value, current_value)


func _get_starting_value_with_modes(change_mode, value_mode, original_value, current_value) -> Vector2:
	# Subclasses should override with correct calculation / value
	return Vector2.ZERO


func _get_new_value(starting_value):
	return _get_new_value_with_modes(change_mode, value_mode, starting_value)


func _get_new_value_with_modes(change_mode, value_mode, starting_value) -> Vector2:
	# Subclasses should override with correct calculation / value
	return Vector2.ZERO

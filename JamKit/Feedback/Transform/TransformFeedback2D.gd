tool
extends BaseTweenTransformFeedback2D
class_name TransformFeedback2D

export (Vector2) var position_change


func _get_starting_value_with_modes(change_mode, value_mode, original_value, current_value) -> Vector2:
	match change_mode:
		BaseTweenTransformFeedback2D.ChangeMode.DISCRETE:
			return original_value
		BaseTweenTransformFeedback2D.ChangeMode.STACK:
			return current_value
			
	return original_value


func _get_new_value_with_modes(change_mode, value_mode, starting_value) -> Vector2:		
	match value_mode:
		BaseTweenTransformFeedback2D.ValueMode.ABSOLUTE:
			return position_change
		BaseTweenTransformFeedback2D.ValueMode.ADDITIVE:
			return starting_value + position_change
		BaseTweenTransformFeedback2D.ValueMode.MULTIPLICATIVE:
			return starting_value * position_change
			
	return original_value

	
func _get_property_name() -> String:
	return "position"

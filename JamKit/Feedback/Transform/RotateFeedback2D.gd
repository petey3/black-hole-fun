tool
extends BaseTweenTransformFeedback2D
class_name RotateFeedback2D

enum RotationUnit {DEGREES, RADIANS}

export (RotationUnit) var unit = RotationUnit.DEGREES
export (float) var rotation_change


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
			return rotation_change
		BaseTweenTransformFeedback2D.ValueMode.ADDITIVE:
			return starting_value + rotation_change
		BaseTweenTransformFeedback2D.ValueMode.MULTIPLICATIVE:
			starting_value = 1 if starting_value == 0 else starting_value
			return starting_value * rotation_change
			
	return original_value

	
func _get_property_name() -> String:
	match unit:
		RotationUnit.RADIANS:
			return "rotation"
		RotationUnit.DEGREES:
			return "rotation_degrees"
			
	return ""

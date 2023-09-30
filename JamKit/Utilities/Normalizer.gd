extends Object
class_name Normalizer
# A utility class for converting
# numbers between a normalized (0-1) value
# and an...uh...un...normalized value (X-Y)

const NORMALIZED_MIN_VALUE = 0.0
const NORMALIZED_MAX_VALUE = 1.0

var min_value 
var max_value

func _init(min_value: float, max_value: float):
	self.min_value = min_value
	self.max_value = max_value
	
# where along the full range of values is the given unnormalized value
func normalize_as_position(value: float) -> float:
	var current_spot_in_range = value - min_value
	return current_spot_in_range / get_full_value_range()
	
	
# how much is the given unnormalized value worth on a normalized scale
func normalize_as_value(value: float) -> float:
	return value / get_full_value_range()


# where along the full range of values is the given normalized value
func unnormalize_as_position(value: float) -> float:
	var current_spot_in_range = value * get_full_value_range()
	return current_spot_in_range + min_value 
	
	
# how much is the given normalized value worth on a unnormalized scale
func unnormalize_as_value(value: float) -> float:
	return value * get_full_value_range()
	

func get_full_value_range() -> float:
	return max_value - min_value

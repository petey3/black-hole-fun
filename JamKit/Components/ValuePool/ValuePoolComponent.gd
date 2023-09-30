extends Node
class_name ValuePoolComponent
# A value pool is the base class for things like Health, Energy, Mana etc

# Things to consider
# continuous vs. chunked vs. hybrid (you can be continuous in a chunk)
# value range (is it always 0-1, can you go over? Can you asssign what 1 means?)
# is there active decay? Is there active healing?
# support for common mechanisms like healing or "receoverable" values
# a class for communicating value pool events
# setting the value 
# "caps" that block the health from progressing through to a higher amount

# Set up basically a "plugin" system for features like
# - decay
# - chunks
# - caps 
# etc

# Make your average HealthComponent a scene with all the plugins already _There_
# but _disabled_ so that a dev can go in and enable/disable the child nodes
# ex.
# _HealthComponent
#  |_DecayPlugin
#  |_ChunkPlugin
#  |_CapPlugin
#  |_HealthSpecificPlugin

class ValuePoolChangeInfo:
	var previous_value: float
	var previous_value_normalized: float
	var current_value: float
	var current_value_normalized: float
	var min_value: float
	var max_value: float
	
	func _init(previous: float, current: float, min_value: float, max_value: float, normalizer: Normalizer):
		self.previous_value = previous
		self.previous_value_normalized = normalizer.normalize_as_position(previous)
		self.current_value = current
		self.current_value_normalized = normalizer.normalize_as_position(current)
		self.min_value = min_value
		self.max_value = max_value
	

# takes in a ValuePoolChangeInfo obj
signal value_changed(change_info)


const MIN_VALUE_NORMALIZED = 0.0
const MAX_VALUE_NORMALIZED = 1.0

export (float) var min_value = 0 setget _on_min_value_set
export (float) var max_value = 1 setget _on_max_value_set
export (float) var current_value = 1
#export (float) var current_percent # TODO: should set/get current_value

var normalizer: Normalizer = null

func _on_min_value_set(value: float):
	normalizer = Normalizer.new(value, max_value)
	
	
func _on_max_value_set(value: float):
	normalizer = Normalizer.new(min_value, max_value)


func _ready():
	normalizer = Normalizer.new(min_value, max_value)
	

func is_full() -> bool:
	return current_value >= max_value
	

func is_empty() -> bool:
	return current_value == min_value


func change_value(amount: float):
	set_value(current_value + amount)
	
	
func change_value_normalized(normalized_amount: float):
	var unnormalized_amount = normalizer.unnormalize_as_value(normalized_amount)
	change_value(unnormalized_amount)
	

func set_value(new_value: float):
	_update_value(new_value)
	

func set_value_normalized(normalized_value: float):
	var unnormalized_value = normalizer.unnormalize_as_position(normalized_value)
	set_value(unnormalized_value)
	
	
func _update_value(new_value: float):
	var previous_value = current_value
	current_value = clamp(new_value, min_value, max_value)
	var change_info = ValuePoolChangeInfo.new(previous_value, current_value, min_value, max_value, normalizer)
	emit_signal("value_changed", change_info)

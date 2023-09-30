extends IntSequencer
class_name CounterSequencer

export (int) var count_to_value
export (float) var time_between_increments
export (bool) var zero_index = true
export (bool) var max_value_inclusive = true

var current_value
var timer

func _ready():
	current_value = 0 if zero_index else 1
	
	# TODO: add utility or base class for 
	# simple timer behavior we want in a class
	# ex. Utility.AddTimer(arg1, arg2, self, ...)
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timeout")
	add_child(timer)
	timer.wait_time = time_between_increments
	timer.one_shot = false
	timer.start()
	

func _on_timeout():
	emit_signal("new_value", current_value)
	current_value += 1
	
	var max_value = count_to_value if max_value_inclusive else count_to_value - 1
	
	if current_value > max_value:
		current_value = 0 if zero_index else 1

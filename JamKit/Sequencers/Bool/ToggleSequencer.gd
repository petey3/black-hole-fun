extends BoolSequencer
class_name ToggleSequencer

export (bool) var starting_value
export (float) var time_between_toggles
export (bool) var auto_start = false

var current_value
var timer
var has_timer_started

func _ready():
	current_value = starting_value
	
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timeout")
	add_child(timer)
	timer.wait_time = time_between_toggles
	timer.one_shot = false
	if auto_start:
		timer.start()
	

func _on_timeout():
	emit_signal("new_value", current_value)
	current_value = not current_value
	
	
func start():
	if has_timer_started:
		return 
		
	timer.start()
	has_timer_started = true

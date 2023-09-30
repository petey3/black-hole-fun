extends BaseFeedback
class_name TweenFeedback

export (float) var run_time
export (bool) var should_return_to_previous = true
export (float) var return_time
export (bool) var can_interrupt = false

var tween
var in_progress = false
var original_value = null
var is_original_value_set = false


func _get_starting_value(original_value, current_value):
	# Subclasses should overwrite with correct calculation / value
	return null

func _get_new_value(starting_value):
	# Subclasses should overwrite with correct calculation / value
	return null
	
	
func _get_property_name() -> String:
	# Subclasses should return the correct property name (ex. "scale")
	return ""
	
	
func _check_tween():
	if not tween:
		tween = Tween.new()
		add_child(tween)

	if tween and tween.is_active() and not can_interrupt:
		return
		
	if not tween.is_connected("tween_completed", self, "_on_tween_finished"):
		tween.connect("tween_completed", self, "_on_tween_finished")
	
	
func _run_change(target: Node, property_name: String, original_value, new_value, duration: float):
	tween.interpolate_property(
		target, 
		property_name, 
		original_value,
		new_value,
		duration,
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT)
	tween.start()
	

func _execute(target: Node):
	._execute(target)
	
	var property_name = _get_property_name()
	if not property_name in target:
		print(get_script().get_path() + ": NO SUCH PROPERTY EXISTS")
		return
	
	var property = target.get(property_name)
	
	_check_tween()
	
	var current_property_value = property
	if not is_original_value_set:
		original_value = current_property_value
		is_original_value_set = true
		
	var starting_value = _get_starting_value(original_value, current_property_value)
	var new_value = _get_new_value(starting_value)
	
	in_progress = true
	_run_change(target, property_name, starting_value, new_value, run_time)
	
	if should_return_to_previous:
		_run_change(target, property_name, new_value, starting_value, return_time)
			

func _on_tween_finished(_object: Object, _key: NodePath):
	in_progress = false 

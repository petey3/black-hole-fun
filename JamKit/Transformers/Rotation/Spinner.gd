extends Node
class_name Spinner

enum SpinDirection { CLOCKWISE, COUNTER_CLOCKWISE }

export (NodePath) var target_path
export (SpinDirection) var spin_direction
export (bool) var spin_forever = true
export (NodePath) var stop_calculator

var is_spinning = false

func _get_target():
	return get_node(target_path)
	

func _get_calculator():
	return get_node(stop_calculator)
	
	
func set_delegate(node: Node):
	var stop_calculator = _get_calculator()
	if stop_calculator:
		stop_calculator.delegate = node
		print(stop_calculator.delegate)
	
	
func _ready():
	is_spinning = true
	var stop_calculator = _get_calculator()
	if stop_calculator:
		stop_calculator.connect("update_spinning_value", self, "_on_update_spinning_value")
	
func _process(delta):
	var target = _get_target()
	if not target:
		return
		
	var current_rotation = target.rotation_degrees
	var rot_speed = rad2deg(5)
	var new_rotation_delta = rot_speed * delta if is_spinning else 0
	
	if is_spinning:
		var direction_multiplier = 1 if spin_direction == SpinDirection.CLOCKWISE else -1
		new_rotation_delta *= direction_multiplier
		var new_rotation = target.rotation_degrees + new_rotation_delta
		target.rotation_degrees = new_rotation
		
	var stop_calculator = _get_calculator()
	if stop_calculator:
		stop_calculator.update(delta, is_spinning, current_rotation, new_rotation_delta)
		


func _on_update_spinning_value(value: bool):
	is_spinning = value

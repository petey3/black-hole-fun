extends DirectionCalculator2D
class_name WASDDirectionCalculator2D

enum MovementFreedom {FOUR_WAY, EIGHT_WAY}
export(MovementFreedom) var movement_freedom

export (bool) var maintain_last_direction = false
export (bool) var has_instant_direction_change = true

onready var last_direction = Vector2.ZERO

func get_current_direction() -> Vector2:
	return last_direction


func _process(delta):
	var new_vector = Vector2.ZERO
	
	match movement_freedom:
		MovementFreedom.FOUR_WAY:
			new_vector = _four_way_vector()
		MovementFreedom.EIGHT_WAY:
			new_vector = _eight_way_vector()
		
	_set_and_update(new_vector)
	
	
func _four_way_vector() -> Vector2:
	if Input.is_action_pressed("standard_move_up"):
		return Vector2.UP
	elif Input.is_action_pressed("standard_move_left"):
		return Vector2.LEFT
	elif Input.is_action_pressed("standard_move_down"):
		return Vector2.DOWN
	elif Input.is_action_pressed("standard_move_right"):
		return Vector2.RIGHT
	else:
		return last_direction if maintain_last_direction else Vector2.ZERO 
	
	
func _eight_way_vector() -> Vector2:
	var input_vector = Input.get_vector("standard_move_left", "standard_move_right", "standard_move_up", "standard_move_down")
	input_vector.normalized()
	
	if input_vector.length() == 0.0 and maintain_last_direction:
		return last_direction
		
	return input_vector
	

	
		
func _add_to_vector(base_vector: Vector2, additional_vector: Vector2) -> Vector2:
	if movement_freedom == MovementFreedom.FOUR_WAY:
		return additional_vector if base_vector == Vector2.ZERO else base_vector
		
	return (base_vector + additional_vector).normalized()


func _set_and_update(new_direction):
	update_direction(last_direction, new_direction)
	last_direction = new_direction

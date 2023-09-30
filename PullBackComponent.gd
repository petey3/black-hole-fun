extends Node
class_name PullBackComponent

signal pull_back_released(direction, power_ratio)

export (float) var max_power_distance = 300

var down_position = Vector2.ZERO
var up_position = Vector2.ZERO

var is_pulling_back = false

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and not is_pulling_back:
			down_position = event.position
			is_pulling_back = true
		elif is_pulling_back and not event.pressed:
			up_position = event.position
			is_pulling_back = false
			var direction: Vector2 = down_position - up_position
			direction = direction.limit_length(max_power_distance)
			print("DIRECTION: " + str(direction))
			var ratio = direction.length() / max_power_distance
			print("RATIO: " + str(ratio))
			emit_signal("pull_back_released", direction, ratio)

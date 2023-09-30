extends Node
class_name PullBackComponent

signal pull_back_started()
signal pull_back_released(force)
signal pulling_back(force, power_ratio)

export (float) var max_power_distance = 100
export (float) var force_multiplier = 30

var down_position = Vector2.ZERO
var up_position = Vector2.ZERO

var is_pulling_back = false
var is_draggable = false

func _process(delta):
	if is_pulling_back and Input.is_mouse_button_pressed(1):
		var direction: Vector2 = get_parent().position - get_viewport().get_mouse_position()
		direction = direction.limit_length(max_power_distance)
		var ratio = direction.length() / max_power_distance
		emit_signal("pulling_back", direction, ratio)

func _input(event):
	if event is InputEventMouseButton:
		if is_draggable and event.pressed and not is_pulling_back:
			down_position = event.position
			is_pulling_back = true
			emit_signal("pull_back_started")
		elif is_pulling_back and not event.pressed:
			up_position = event.position
			is_pulling_back = false
			var force: Vector2 = down_position - up_position
			force = force.limit_length(max_power_distance)
			emit_signal("pull_back_released", force * force_multiplier)

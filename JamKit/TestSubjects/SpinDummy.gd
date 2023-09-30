extends Node2D

onready var spinner = $Spinner
onready var sprite = $Sprite

func _ready():
	spinner.set_delegate(self)

func get_should_spin_value(current_is_spinning, total_time_spun, current_rotation_degrees, total_degrees_rotated, number_of_full_rotations) -> bool:
	# Spin for 3 full rotations, then stop, then resume indefinitely after 10 seconds have passed
	return number_of_full_rotations < 3 or total_time_spun > 10

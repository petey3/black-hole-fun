extends Node2D

onready var x_sequencer = $XSequencer
onready var y_sequencer = $YSequencer

var start_position = Vector2.ZERO

func _ready():
	start_position = position
	x_sequencer.connect("new_value", self, "_on_x_value")
	y_sequencer.connect("new_value", self, "_on_y_value")


func _on_x_value(value: float):
	position.x = start_position.x + value


func _on_y_value(value: float):
	position.y = start_position.y + value

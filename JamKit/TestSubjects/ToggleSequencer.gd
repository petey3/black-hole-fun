extends Node2D

onready var toggle_sequencer = $ToggleSequencer
onready var sprite = $Sprite

func _ready():
	toggle_sequencer.connect("new_value", self, "_on_new_value")
	

func _on_new_value(value: bool):
	sprite.modulate.a = 1 if value else 0.5

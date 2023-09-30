extends Node2D

onready var counter_sequencer = $CounterSequencer
onready var sprite = $Sprite

func _ready():
	counter_sequencer.connect("new_value", self, "_on_new_value")
	

func _on_new_value(value: int):
	var tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(value, value), 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)


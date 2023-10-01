extends Node2D
class_name Gameplay_Context_World

func _on_BlackHole_swallow_body(body):
	body.queue_free()

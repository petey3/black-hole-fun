extends Node2D

onready var player_ball = $PlayerBall

func _on_BlackHole_swallow_ball(ball):
	ball.queue_free()

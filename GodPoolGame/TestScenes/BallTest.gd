extends Node2D

onready var player_ball = $PlayerBall

export (float) var force_max = 30

func _on_PullBackComponent_pull_back_released(direction, power_ratio):
	var force = power_ratio * force_max
	player_ball.apply_impulse(Vector2.ZERO, direction * force)


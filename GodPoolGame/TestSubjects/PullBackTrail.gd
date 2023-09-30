extends Node2D

var low_sprite = "res://Assets/Hands/hand_low.png"
var medium_sprite = "res://Assets/Hands/hand_mid.png"
var high_sprite = "res://Assets/Hands/hand_high.png"
var release_sprite = "res://Assets/Hands/hand_release.png"
onready var hand_sprite = $HandSprite

func _on_PullBackComponent_pulling_back(direction, power_ratio):
	print(power_ratio)
	if power_ratio < .3:
		hand_sprite.texture = load(low_sprite)
	elif power_ratio < .6:
		hand_sprite.texture = load(medium_sprite)
	else:
		hand_sprite.texture = load(high_sprite)


func _on_PullBackComponent_pull_back_released(direction, power_ratio):
		hand_sprite.texture = load(release_sprite)

extends Node2D

onready var movement_component = $MovementComponent2D

func _ready():
	movement_component.target = self

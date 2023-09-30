extends RigidBody2D


var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var stored_force = Vector2.ZERO
onready var pull_back_component = $PullBackComponent
onready var pointer_sprite = $Pointer
onready var pull_back_trail_container = $PullBackTrail

func _ready():
	pointer_sprite.visible = false
	pull_back_trail_container.visible = false

func _process(delta):
	rotation = 0

func _on_PullBackComponent_pull_back_released(force):
	stored_force = force
	pointer_sprite.visible = false
	pointer_sprite.rotation = 0


func _on_PullBackComponent_pulling_back(direction, power_ratio):
	set_pull_back_trail(direction,power_ratio)
	set_pointer(direction, power_ratio)

func _on_TestBall_mouse_entered():
	pull_back_component.is_draggable = true


func _on_TestBall_mouse_exited():
	pull_back_component.is_draggable = false


func set_pull_back_trail(direction, power_ratio):
	if power_ratio == 0:
		pull_back_trail_container.visible = false
		return

	var length: float = Vector2.ZERO.distance_to(direction)
	var angle = Vector2.ZERO.angle_to_point(direction) - 1.5708
	pull_back_trail_container.rotation = angle
	pull_back_trail_container.position = - direction * .2
	pull_back_trail_container.visible = true

func set_pointer(direction, power_ratio):
	if power_ratio == 0:
		pointer_sprite.visible = false
		return
		
	var angle = Vector2.ZERO.angle_to_point(direction) - 1.5708
	pointer_sprite.rotation = angle
	pointer_sprite.position = direction * .5
	pointer_sprite.visible = true

func _on_FlickTimmer_timeout():
	apply_impulse(Vector2.ZERO, stored_force)
	stored_force = Vector2.ZERO
	pull_back_trail_container.visible = false
	pull_back_trail_container.rotation = 0


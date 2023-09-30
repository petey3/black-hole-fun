extends RigidBody2D

export (bool) var is_under_control = false

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

func _input(event):
	if not is_under_control:
		return
	
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		direction = event.position - self.position
#		add_force(Vector2.ZERO, direction)
		apply_impulse(Vector2.ZERO, direction * 5)
		
		
func _physics_process(delta):
#	velocity = direction * 100
#	move_and_slide(velocity * delta)
	pass

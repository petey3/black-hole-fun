extends RigidBody2D

signal swallow_ball(Ball)

export (float) var strength = 100
export (float) var influence = 1000
export (float) var dead_zone = 5
export (float) var kill_zone_radius = 10


func _ready():
	pass


func _physics_process(delta):
	var balls = get_tree().get_nodes_in_group('Balls')
	for ball in balls:
		var direction = position.direction_to(ball.position)
		var sq_magnitude = position.distance_squared_to(ball.position)
		
		if sq_magnitude < kill_zone_radius * kill_zone_radius:
			emit_signal("swallow_ball", ball)
		
		var output_magnitude = (1 / (sq_magnitude + influence)) * (influence * strength)
		if output_magnitude < dead_zone:
			output_magnitude = 0
		
		var motion_vector = -output_magnitude * direction
		ball.apply_central_impulse(motion_vector)

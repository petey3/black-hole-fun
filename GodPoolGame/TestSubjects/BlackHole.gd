extends RigidBody2D
class_name BlackHole

const SWALLOW_METHOD = "_on_swallowed_by_blackhole"

signal swallow_body(body)

export (float) var strength = 200
export (float) var influence = 1500
export (float) var dead_zone = 5
export (float) var kill_zone_radius = 10


func _ready():
	var tween = create_tween()
	tween.tween_property($Node2D/SpiralArms, "rotation_degrees", 360, 10)
	tween.tween_property($Node2D/SpiralArms, "rotation_degrees", 0, 0)
	tween.set_loops()
	tween.play()
	pass


func _physics_process(delta):
	var celestial_bodies = get_tree().get_nodes_in_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_MOVEABLE)
	for body in celestial_bodies:
		var direction = position.direction_to(body.position)
		var sq_magnitude = position.distance_squared_to(body.position)
#		body.global_position # load bearing be wary of removing
		var is_in_kill_zone = sq_magnitude < kill_zone_radius * kill_zone_radius
		var is_swallowable = body.is_in_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_SWALLOWABLE)
		if is_in_kill_zone and is_swallowable:
			if body.has_method(SWALLOW_METHOD):
				body.call(SWALLOW_METHOD)
			emit_signal("swallow_body", body)
			continue
		
		var output_magnitude = (1 / (sq_magnitude + influence)) * (influence * strength)
		if output_magnitude < dead_zone:
			output_magnitude = 0
		
		var motion_vector = -output_magnitude * direction
		body.apply_central_impulse(motion_vector)

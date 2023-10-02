extends RigidBody2D
class_name BlackHole

const SWALLOW_METHOD = "_on_swallowed_by_blackhole" # expects 1 Vector2 arg

signal swallow_body(body)

export (float) var strength = 200
export (float) var influence = 1500
export (float) var dead_zone = 5
export (float) var kill_zone_radius = 10

onready var halo_sprite = $Node2D/Halo
onready var hole_sprite = $Node2D/Hole

onready var primary_wave_sequencer = $WaveSequencers/PrimaryScaleWaveSequencer
onready var halo_x_wave_sequencer = $WaveSequencers/HaloXWaveSequencer
onready var halo_y_wave_sequencer = $WaveSequencers/HaloYWaveSequencer

var halo_sprite_starting_position

func _ready():
	var tween = create_tween()
	tween.tween_property($Node2D/SpiralArms, "rotation_degrees", 360.0, 10.0)
	tween.tween_property($Node2D/SpiralArms, "rotation_degrees", 0.0, 0.0)
	tween.set_loops()
	tween.play()
	
	primary_wave_sequencer.connect("new_value", self, "_on_new_wave_value")
	halo_x_wave_sequencer.connect("new_value", self, "_on_new_x_wave_value")
	halo_y_wave_sequencer.connect("new_value", self, "_on_new_y_wave_value")

	halo_sprite_starting_position = halo_sprite.position

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
				body.call(SWALLOW_METHOD, position)
			emit_signal("swallow_body", body)
			continue
		
		var output_magnitude = (1 / (sq_magnitude + influence)) * (influence * strength)
		if output_magnitude < dead_zone:
			output_magnitude = 0
		
		var motion_vector = -output_magnitude * direction
		body.apply_central_impulse(motion_vector)


func _on_new_wave_value(new_value: float):
	hole_sprite.scale.x = 0.7 + (new_value * 0.4)
	hole_sprite.scale.y = 0.7 + (new_value * 0.4)


func _on_new_x_wave_value(new_value: float):
	halo_sprite.position.x = halo_sprite_starting_position.x + new_value * 0.3
	
func _on_new_y_wave_value(new_value: float):
	halo_sprite.position.y = halo_sprite_starting_position.y + new_value * 0.3

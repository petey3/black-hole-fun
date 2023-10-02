extends CelestialBody
class_name Planet

export (int) var population = 0 setget _set_population

onready var sprite_face = $Sprite/Face
onready var sprite_effect = $Sprite/Effect

onready var wave_sequencer = $WaveSequencer
onready var hit_feedback_runner = $HitFeedbackRunner
onready var captured_feedback_runner = $CapturedFeedbackRunner
onready var transform_feedback = $CapturedFeedbackRunner/TransformFeedback2D

var idle_rotation_value = 0
var random_rotation_offset = 0

func _ready():
	randomize()
	var bases = [
		preload("res://Assets/Planets/Base/plain.png"),
		preload("res://Assets/Planets/Base/lumpy.png"),
		preload("res://Assets/Planets/Base/spike.png"),
		preload("res://Assets/Planets/Base/disco.png"),
		preload("res://Assets/Planets/Base/super.png"),
	]
	var effects = [
		preload("res://Assets/Planets/Effects/bubble.png"),
		preload("res://Assets/Planets/Effects/clouds.png"),
		preload("res://Assets/Planets/Effects/goopy.png"),
		preload("res://Assets/Planets/Effects/ring-moon.png"),
		preload("res://Assets/Planets/Effects/squiggles.png"),
		preload("res://Assets/Planets/Effects/vine.png"),
	]
	var faces = [
		preload("res://Assets/Planets/Faces/grin.png"),
		preload("res://Assets/Planets/Faces/hyper.png"),
		preload("res://Assets/Planets/Faces/mellow.png"),
		preload("res://Assets/Planets/Faces/oh.png"),
		preload("res://Assets/Planets/Faces/stinker.png"),
	]
	sprite.texture = bases[randi() % 5]
	sprite_effect.texture = effects[randi() % 5]
	sprite_face.texture = faces[randi() % 5]
	
	if population == 0:
		sprite_face.visible = false
	
	idle_rotation_value = Random.randf_range(10.0, 20.0)
	random_rotation_offset = Random.randf_range(idle_rotation_value * -1, idle_rotation_value)
	wave_sequencer.period = Random.randf_range(0.3, 2)
	wave_sequencer.connect("new_value", self, "_on_new_wave_value")	
	
		

func has_life() -> bool:
	return population > 0


func _set_population(p):
	population = p
	if sprite_face == null:
		return
	
	if population == 0:
		sprite_effect.visible = false
	else:
		sprite_effect.visible = true


func _add_to_groups():
	._add_to_groups()
	add_to_group(GodPoolGameConstants.GROUP_ID_PLANET)
	add_to_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_SWALLOWABLE)
	add_to_group(GodPoolGameConstants.GROUP_ID_VOID_SWALLOWABLE)
	add_to_group(GodPoolGameConstants.GROUP_ID_WHITE_HOLE_CAPTURABLE)


func _on_body_entered(node: Node):
	hit_feedback_runner.execute_feedbacks()
	._on_body_entered(node)


func _on_void_destroy():
	var void_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.VOID, population)
	EventServices.dispatch().broadcast(void_event)
	._on_void_destroy()


func _on_swallowed_by_blackhole(blackhole_center: Vector2):
	var blackhole_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.BLACKHOLE, population)
	EventServices.dispatch().broadcast(blackhole_event)
	
	_run_capture_sequence(blackhole_center)


func _on_collide_with_whitehole(whitehole_center: Vector2):
	var whitehole_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.WHITEHOLE, population)
	EventServices.dispatch().broadcast(whitehole_event)
		
	_run_capture_sequence(whitehole_center)


func _on_new_wave_value(new_value: float):
	if has_been_swallowed_or_captured:
		return
		
	sprite.rotation_degrees = (new_value * idle_rotation_value) + random_rotation_offset


func _run_capture_sequence(move_center: Vector2):
	if has_been_swallowed_or_captured:
		return 
	
	has_been_swallowed_or_captured = true
	
	hit_feedback_runner.execute_feedbacks()
	var hit_feedback_timer = InlineTimer.wait(self, 0.1)
	yield(hit_feedback_timer.timer, hit_feedback_timer.timeout)
	
	transform_feedback.position_change = move_center
	captured_feedback_runner.execute_feedbacks()
	var captured_feedback_timer = InlineTimer.wait(self, 0.3)
	yield(captured_feedback_timer.timer, captured_feedback_timer.timeout)
	
	queue_free()

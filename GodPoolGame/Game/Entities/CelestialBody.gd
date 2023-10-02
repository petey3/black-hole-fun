extends RigidBody2D
class_name CelestialBody

export (float) var linear_velocity_lower_limit = 15

onready var collision_shape = $CollisionShape2D
onready var sprite = $Sprite

var should_destroy_on_contact = false
var has_been_swallowed_or_captured = false

func _ready():
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_changed")
	if not self.is_connected("body_entered", self, "_on_body_entered"):
		self.connect("body_entered", self, "_on_body_entered")
	_add_to_groups()


func _add_to_groups():
	add_to_group(GodPoolGameConstants.GROUP_ID_CELESTIAL_BODY)
	add_to_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_MOVEABLE)


func _physics_process(delta):
	if linear_velocity.length() < linear_velocity_lower_limit:
		linear_velocity = Vector2.ZERO


func _on_body_entered(body: Node):
	if _should_destroy_from_void():
		_on_void_destroy()
		

func _on_void_destroy():
	print("OVERRIDE - destroy on void")
	queue_free()
	
	
func _on_level_state_changed(event: Event):
	var level_change_event := event as LevelStateChangeEvent
	if not level_change_event:
		return
		
	should_destroy_on_contact = not level_change_event.is_player_in_control
	if _should_destroy_from_void():
		_on_void_destroy()
	

func _should_destroy_from_void() -> bool:
	var void_swallowable = is_in_group(GodPoolGameConstants.GROUP_ID_VOID_SWALLOWABLE)
	# TODO: Check that this isn't another ball!
	# TODO: Check that this isn't another ball!
	var in_contact_with_void = get_colliding_bodies().size() > 0

	return void_swallowable and in_contact_with_void and should_destroy_on_contact


func _on_swallowed_by_blackhole():
	has_been_swallowed_or_captured = true
	print("BLACKHOLED")
	queue_free()


func _on_collide_with_whitehole():
	has_been_swallowed_or_captured = true
	print("WHITEHOLED")
	queue_free()

extends CelestialBody
class_name CelestialCueBall

onready var pull_back_component = $PullBackComponent
onready var pointer_sprite = $Pointer
onready var pull_back_trail_container = $PullBackTrail
onready var flick_timer = $PullBackTrail/FlickTimer

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var stored_force = Vector2.ZERO
var shot_start_pos = Vector2.ZERO


func _ready():
	._ready()
	_setup_signals()

	pointer_sprite.visible = false
	pull_back_trail_container.visible = false
	
	
func _setup_signals():	
	pull_back_component.connect("pulling_back", self, "_on_pulling_back")
	pull_back_component.connect("pull_back_released", self, "_on_pull_back_released")
	flick_timer.connect("timeout", self, "_on_flick_timer_timeout")
	
	self.connect("mouse_entered", self, "_on_mouse_entered")
	self.connect("mouse_exited", self, "_on_mouse_exited")
	
	
func _process(delta):
	rotation = 0
	

func _physics_process(delta):
	if linear_velocity.length() < linear_velocity_lower_limit:
		linear_velocity = Vector2.ZERO


func _on_pull_back_released(force):
	shot_start_pos = position
	stored_force = force
	pointer_sprite.visible = false
	pointer_sprite.rotation = 0


func _on_pulling_back(direction, power_ratio):
	set_pull_back_trail(direction,power_ratio)
	set_pointer(direction, power_ratio)


func _on_mouse_entered():
	pull_back_component.is_draggable = true


func _on_mouse_exited():
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


func _on_flick_timer_timeout():
	apply_impulse(Vector2.ZERO, stored_force)
	stored_force = Vector2.ZERO
	pull_back_trail_container.visible = false
	pull_back_trail_container.rotation = 0
		

func _add_to_groups():
	add_to_group(GodPoolGameConstants.GROUP_ID_CELESTIAL_BODY)
	add_to_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_MOVEABLE)
	add_to_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_SWALLOWABLE)

		
func _on_destroy():
	queue_free()

func _on_swallowed_by_blackhole():
	linear_velocity = Vector2.ZERO
	velocity = Vector2.ZERO
	position = shot_start_pos

	

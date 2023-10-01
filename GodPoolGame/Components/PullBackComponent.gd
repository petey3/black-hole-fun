extends Node
class_name PullBackComponent

signal pull_back_started()
signal pull_back_released(force)
signal pulling_back(force, power_ratio)

export (float) var max_power_distance = 100
export (float) var force_multiplier = 30

var down_position = Vector2.ZERO
var up_position = Vector2.ZERO

var is_pulling_back = false
var is_draggable = false

var is_enabled = true

func _ready():
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_changed")


func _process(delta):
	if not is_enabled:
		return
	
	if is_pulling_back and Input.is_mouse_button_pressed(1):
		var direction: Vector2 = get_parent().position - get_parent().get_global_mouse_position()
		direction = direction.limit_length(max_power_distance)
		var ratio = direction.length() / max_power_distance
		emit_signal("pulling_back", direction, ratio)


func _input(event):
	if not is_enabled:
		return
		
	if event is InputEventMouseButton:
		if is_draggable and event.pressed and not is_pulling_back:
			down_position = event.position
			is_pulling_back = true
			emit_signal("pull_back_started")
		elif is_pulling_back and not event.pressed:
			up_position = event.position
			is_pulling_back = false
			var force: Vector2 = down_position - up_position
			force = force.limit_length(max_power_distance)
			emit_signal("pull_back_released", force * force_multiplier)
			var player_shot_event = PlayerShot.new()
			EventServices.dispatch().broadcast(player_shot_event)
			is_enabled = false
			
		
func _on_level_state_changed(event: Event):
	var level_event := event as LevelStateChangeEvent
	if not level_event:
		return
		
	is_enabled = level_event.is_player_in_control
	is_draggable = is_enabled

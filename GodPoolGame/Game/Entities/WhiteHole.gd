extends CelestialArea
class_name WhiteHole

const CAPTURE_METHOD = "_on_collide_with_whitehole"

onready var wave_sequencer = $WaveSequencer

func _ready():
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_changed")
	if not area.is_connected("body_entered", self, "_on_body_entered"):
		area.connect("body_entered", self, "_on_body_entered")
	_add_to_groups()
	
	wave_sequencer.connect("new_value", self, "_on_new_wave_value")


func _add_to_groups():
	add_to_group(GodPoolGameConstants.GROUP_ID_WHITE_HOLE)


func _on_body_entered(body: Node):
	var planet := body as Planet
	if not planet:
		return
		
	if planet.has_life():
		print("SAVED LIVES")
	else:
		print("NOTHING TO SAVE")
		
	if planet.has_method(CAPTURE_METHOD):
		print("CALLING WHITEHOLE CAPTURE")
		planet.call(CAPTURE_METHOD)
		
	
func _on_level_state_changed(event: Event):
	pass
	

func _should_destroy_from_void() -> bool:
	return false
	
	
func _on_new_wave_value(wave_value: float):
	sprite.position.y = wave_value

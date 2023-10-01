extends CelestialArea
class_name WhiteHole

const CAPTURE_METHOD = "_on_collide_with_whitehole"

func _ready():
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_changed")
	if not area.is_connected("body_entered", self, "_on_body_entered"):
		area.connect("body_entered", self, "_on_body_entered")
	_add_to_groups()


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
		planet.call(CAPTURE_METHOD)
		
		
#func _on_void_destroy():
#	print("OVERRIDE - destroy on void")
	
	
func _on_level_state_changed(event: Event):
#	var level_change_event := event as LevelStateChangeEvent
#	if not level_change_event:
#		return
#
#	should_destroy_on_contact = not level_change_event.is_player_in_control
#	if _should_destroy_from_void():
#		_on_void_destroy()
	pass
	

func _should_destroy_from_void() -> bool:
#	var void_swallowable = is_in_group(GodPoolGameConstants.GROUP_ID_VOID_SWALLOWABLE)
#	# TODO: Check that this isn't another ball!
#	# TODO: Check that this isn't another ball!
#	var in_contact_with_void = get_colliding_bodies().size() > 0
#
#	return void_swallowable and in_contact_with_void and should_destroy_on_contact
	return false

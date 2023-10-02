extends Control
class_name GameplayHUD

const LOST_HEADER_STRING = "OH NO!"
const LOST_BODY_STRING = "You did not save any of the planets :("

const GOOD_HEADER_STRING = "Good Job"
const GOOD_BODY_STRING = "You saved some of the planets from annihilation!"

const PERFECT_HEADER_STRING = "PERFECT!"
const PERFECT_BODY_STRING = "You saved ALL of the planets from destruction! Well done!"

onready var menu = $Menu
onready var friends = $Friends
onready var next_button = $Menu/NextButton
onready var restart_button = $Menu/RestartButton
onready var header_label = $Menu/HeaderLabel
onready var body_label = $Menu/BodyLabel

func _ready():
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_change")
	EventServices.dispatch().subscribe(ReloadedCurrentSceneEvent.ID, self, "_on_reloaded_current_scene")
	restart_button.connect("pressed", self, "_on_restart_pressed")
	next_button.connect("pressed", self, "_on_next_pressed")
	menu.visible = false
	friends.visible = true
	next_button.disabled = true

	
func _on_level_state_change(event: Event):
	var level_event := event as LevelStateChangeEvent
	if not level_event:
		return
		
	if level_event.state_id == LossConditionMetState.ID:
		header_label.text = _get_header_string(false)
		body_label.text = _get_body_string(false)
		menu.visible = true
		friends.visible = false
	elif level_event.state_id == WinConditionMetState.ID:
		header_label.text = _get_header_string(true)
		body_label.text = _get_body_string(true)
		menu.visible = true
		friends.visible = false
	else:
		friends.visible = true
	
	next_button.disabled = not level_event.can_go_to_next_level


func _on_reloaded_current_scene(event: Event):
	pass


func _on_restart_pressed():
	GameplayServices.levels().reload_current_scene()
	next_button.disabled = true
	menu.visible = false
	friends.visible = true


func _on_next_pressed():
	menu.visible = false
	friends.visible = true
	GameplayServices.levels().next_level()


func _get_header_string(did_win: bool) -> String:
	if not did_win:
		return LOST_HEADER_STRING
		
	elif GameplayServices.entities().are_all_live_planets_saved():
		return PERFECT_HEADER_STRING
	else:
		return GOOD_HEADER_STRING
		
		
func _get_body_string(did_win: bool) -> String:
	if not did_win:
		return LOST_BODY_STRING
		
	elif GameplayServices.entities().are_all_live_planets_saved():
		return PERFECT_BODY_STRING
	else:
		return GOOD_BODY_STRING

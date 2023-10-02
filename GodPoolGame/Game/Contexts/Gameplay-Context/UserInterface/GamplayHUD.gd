extends Control
class_name GameplayHUD

onready var label = $Label
onready var restart_button = $RestartButton
onready var next_button = $NextButton

func _ready():
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_change")
	EventServices.dispatch().subscribe(ReloadedCurrentSceneEvent.ID, self, "_on_reloaded_current_scene")
	restart_button.connect("pressed", self, "_on_restart_pressed")
	next_button.connect("pressed", self, "_on_next_pressed")
	visible = false
	next_button.disabled = true

	
func _on_level_state_change(event: Event):
	var level_event := event as LevelStateChangeEvent
	if not level_event:
		return
		
	if level_event.state_id == LossConditionMetState.ID:
		label.text = "WASTED"
		visible = true
	elif level_event.state_id == WinConditionMetState.ID:
		label.text = "WINNER"
		visible = true
		next_button.disabled = not level_event.can_go_to_next_level


func _on_reloaded_current_scene(event: Event):
	pass



func _on_restart_pressed():
	GameplayServices.levels().reload_current_scene()
	next_button.disabled = true
	visible = false
	

func _on_next_pressed():
	visible = false
	GameplayServices.levels().next_level()

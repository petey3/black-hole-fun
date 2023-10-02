extends Control
class_name GameplayHUD

onready var label = $Label
onready var restart_button = $RestartButton
onready var next_button = $NextButton

func _ready():
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_change")
	restart_button.connect("pressed", self, "_on_restart_pressed")
	visible = false

	
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


func _on_restart_pressed():
	GameplayServices.levels().reload_current_scene()

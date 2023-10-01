extends Control
class_name GameplayHUD

onready var label = $Label

func _ready():
	EventServices.dispatch().subscribe(LevelStateChangeEvent.ID, self, "_on_level_state_change")
	label.visible = false

	
func _on_level_state_change(event: Event):
	var level_event := event as LevelStateChangeEvent
	if not level_event:
		return
		
	if level_event.state_id == LossConditionMetState.ID:
		label.visible = true


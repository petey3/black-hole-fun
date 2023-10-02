extends Control
class_name GameplayHUD

onready var menu = $Menu
onready var friends = $Friends
onready var next_button = $Menu/NextButton
onready var restart_button = $Menu/RestartButton
onready var label = $Menu/Label

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
		label.text = "WASTED"
		menu.visible = true
		friends.visible = false
	elif level_event.state_id == WinConditionMetState.ID:
		label.text = "WINNER"
		menu.visible = true
		friends.visible = false
		next_button.disabled = not level_event.can_go_to_next_level
	else:
		friends.visible = true

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

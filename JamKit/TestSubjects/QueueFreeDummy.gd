extends Node2D

onready var toggle_sequencer = $ToggleSequencer
onready var warning_feedback_runner = $WarningFeedbackRunner
onready var rip_feedback_runner = $RIPFeedbackRunner

var warnings_left = 3

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		toggle_sequencer.start()


func _on_ToggleSequencer_new_value(value: bool):
	if value:
		warning_feedback_runner.execute_feedbacks()
		warnings_left -= 1 
		
	if warnings_left < 0:
		rip_feedback_runner.execute_feedbacks()

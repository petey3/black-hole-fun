tool
extends Node
class_name FeedbackRunner

export (bool) var run = false setget _editor_execute
export (bool) var is_debug_trigger_enabled = true

func _editor_execute(_value = null):
	execute_feedbacks()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and is_debug_trigger_enabled:
		execute_feedbacks()


func execute_feedbacks():
	for child in get_children():
		var child_feedback := child as BaseFeedback
		if child_feedback:
			child_feedback.execute()

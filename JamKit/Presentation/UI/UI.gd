extends Control
class_name UI
# The base class for presentable Controls and UI

func focus_id() -> String:
	assert(false, "'focus_id' must be implemented in child classes")
	return ""


func on_set_up():
	# Lifecycle function for when the UI has been instantiated
	# but not yet added to the tree
	pass
	

func on_break_down():
	# Lifecycle function called right before the UI is freed
	pass

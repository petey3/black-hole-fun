extends Node
class_name Context
# A specific combination set of scenes that represents
# a particular context for the player that is different
# from other context (for example, Title Screen vs. Gameplay) 
# How exactly you draw those borders is game specific 

signal transition_to_other_context(contex_id)

func context_id_string() -> String:
	assert(false, "'context_id_string' must be implemented by children")
	return ""
	

func on_set_up():
	# Lifecycle function for when the UI has been instantiated
	# but not yet added to the tree
	pass
	
	
func on_break_down():
	# Lifecycle function called right before the UI is freed
	pass
	

func change_context(context_key: String):
	emit_signal("transition_to_other_context", context_key)

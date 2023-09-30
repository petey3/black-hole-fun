extends Node
class_name UIPresentationService
# Handle the presentation and management of screen UI

var root_control: Control
var ui_stack = []

func set_root_control(given_control: Control):
	root_control = given_control
	print("Root control is now: " + str(given_control))


func present_ui(ui: UI):
	if not root_control:
		return
		
	ui.on_set_up()
	root_control.add_child(ui)
	ui_stack.append(ui)
	
	
func dismiss_top_ui():
	if ui_stack.empty():
		return
		
	var top_ui = ui_stack.pop_back()
	top_ui.on_break_down()
	top_ui.queue_free()
	

func dismiss_to_root():
	while not ui_stack.empty():
		dismiss_top_ui()
	
	
func top_ui_focus_id() -> String:
	if ui_stack.empty():
		return ""
		
	var top_ui = ui_stack[ui_stack.size() - 1]
	return top_ui.focus_id()


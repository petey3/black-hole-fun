extends UI
class_name RandomColorOverlay

signal dismiss_requested()
signal present_new_requested()

onready var color_center = $ColorCenter
onready var hex_values = [
	"#00FF00",
	"#0000FF",
	"#FF0000",
	"#01FFFE",
	"#FFA6FE",
	"#FFDB66"
]
	
var assigned_hex = ""
var _focus_id = ""

func focus_id() -> String:
	return _focus_id
	

func _ready():
	hex_values.shuffle()
	var random_hex_value = hex_values[0]
	color_center.modulate = Color(random_hex_value)
	assigned_hex = random_hex_value
	_focus_id = assigned_hex + str(Random.randi())
	
	
func _gui_input(event):
	print("Got GUI input: " + str(event))
	

func _unhandled_input(event):
	var is_handled = false
	
	if event.is_action_pressed("test_overlay_add"):
		_on_present_another_overlay_pressed()
		is_handled = true
	elif event.is_action_pressed("test_overlay_dismiss"):
		_on_dismiss_pressed()
		is_handled = true
	elif event.is_action_pressed("test_overlay_dismiss_all"):
		PresentationServices.ui_service.dismiss_to_root()
		is_handled = true
		
	if is_handled:
		get_tree().set_input_as_handled()
	

func _on_dismiss_pressed():
	emit_signal("dismiss_requested")


func _on_present_another_overlay_pressed():
	emit_signal("present_new_requested")

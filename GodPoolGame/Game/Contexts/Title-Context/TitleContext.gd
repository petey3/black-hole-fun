extends Context
class_name TitleContext

const CONTEXT_ID = "context.title"

onready var color_rect = $ColorRect

func context_id_string() -> String:
	return CONTEXT_ID


func _ready():
	PresentationServices.ui_service.set_root_control(color_rect)
	
	
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		_on_go_to_game_pressed()
	
	
func _on_go_to_game_pressed():
	change_context(GameplayContext.CONTEXT_ID)

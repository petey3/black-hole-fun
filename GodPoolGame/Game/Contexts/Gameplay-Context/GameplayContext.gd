extends Context
class_name GameplayContext

const CONTEXT_ID = "context.gameplay"

onready var gameplay_context_ui = $"Gameplay-Context-UI-Root/CanvasLayer/Gameplay-Context-UI"

func context_id_string() -> String:
	return CONTEXT_ID


func _ready():
	PresentationServices.ui_service.set_root_control(gameplay_context_ui)
	

extends Node
class_name GodPoolGameApplication

var title_context_scene = preload("res://GodPoolGame/Game/Contexts/Title-Context/TitleContext.tscn")
var gameplay_context_scene = preload("res://GodPoolGame/Game/Contexts/Gameplay-Context/GameplayContext.tscn")

onready var context_root = $ContextRoot

func _ready():
	# wire up the preloaded scenes
	var context_scene_dictionary = { 
		TitleContext.CONTEXT_ID : title_context_scene, 
		GameplayContext.CONTEXT_ID : gameplay_context_scene
		}
		
	PresentationServices.context_service.context_root = context_root
	PresentationServices.context_service.load_with_context_scene_dictionary(context_scene_dictionary)
	PresentationServices.context_service.handle_transition_request(TitleContext.CONTEXT_ID)

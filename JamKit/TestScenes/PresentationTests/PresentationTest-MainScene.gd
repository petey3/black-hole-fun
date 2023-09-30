extends Node
# PresentationTest-MainScene

var title_context_scene = preload("res://TestScenes/PresentationTest/PresentationTest-TitleScene.tscn")
var gameplay_context_scene = preload("res://TestScenes/PresentationTest/PresentationTest-GameScene.tscn")

onready var context_root = $ContextRoot

func _ready():
	# wire up the preloaded scenes
	var context_scene_dictionary = { 
		"title" : title_context_scene, 
		"gameplay" : gameplay_context_scene
		}
		
	PresentationServices.context_service.context_root = context_root
	PresentationServices.context_service.load_with_context_scene_dictionary(context_scene_dictionary)
	PresentationServices.context_service.handle_transition_request("title")

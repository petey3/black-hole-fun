extends Node
# class_name PresentationServices
# Holds onto services that handle the following
# - transitioning between contexts
# - presenting and handling UI 

onready var context_service = $ContextService
onready var ui_service = $UIService

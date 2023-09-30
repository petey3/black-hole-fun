extends Node
# class_name EventServices
# Holds onto services relevant to global 
# (and potentially local) dispatch and communication

onready var dispatch_service = $DispatchService

func dispatch() -> EventDispatchService:
	return dispatch_service

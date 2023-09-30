tool
extends Node
class_name BaseFeedback

export (NodePath) var TargetPath
export (bool) var run = false setget _editor_execute

func _editor_execute(_value = null):
	execute()


func execute():
	_execute(get_node(TargetPath))


func _execute(_target: Node):
	# Subclasses to handle behavior
	pass

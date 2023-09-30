extends TweenFeedback
class_name TweenFeedback2D

func _execute(target: Node):
	._execute(target)
	
	var target_2D := target as Node2D
	if target_2D:
		_execute_2D(target_2D)
	

func _execute_2D(target_2D: Node2D):
	# Subclasses to handle behavior with a guarantee
	# of a Node2D 
	pass

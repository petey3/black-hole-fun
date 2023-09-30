extends BaseFeedback
class_name QueueFreeFeedback

export (float) var delay = 0.0
export (bool) var call_deferred = true

func _execute(target: Node):
	if delay > 0: 
		var inline_timer = InlineTimer.wait(self, delay)
		yield(inline_timer.timer, inline_timer.timeout)
		_queue_free_target(target)
	else:
		_queue_free_target(target)
		
	
func _queue_free_target(target: Node):
	if call_deferred:
		target.call_deferred("queue_free")
	else:
		target.queue_free()

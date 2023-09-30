class_name InlineTimer
# Turns out the yield(get_tree... method can cause problems if you queue_free
# so instead we're going to quietly add a timer child

class TimerPair:
	var timer: Timer
	var timeout = "timeout"
	

static func wait(calling_node: Node, time: float, name_extension: String = "") -> TimerPair:
	var timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.name = calling_node.name + ": INLINE-TIMER - " + name_extension
	
	calling_node.add_child(timer)
	
	var pair = TimerPair.new()
	pair.timer = timer
	
	timer.start(time)
	return pair

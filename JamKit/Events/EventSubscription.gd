extends Object
class_name EventSubscription

var event_id
var subscriber
var function_name

func _init(event_id, subscriber, function_name):
	._init()
	self.event_id = event_id
	self.subscriber = subscriber
	self.function_name = function_name

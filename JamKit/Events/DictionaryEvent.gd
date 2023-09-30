extends Event
class_name DictionaryEvent
# A simple event type that stores arbitrary
# info in a dictionary struct

var info_dictionary = Dictionary()

#static func create_new(event_id, info_dictionary: Dictionary) -> DictionaryEvent:
#	var dictionary_event_script = load("res://Events/DictionaryEvent.gd")
#	var dictionary_event = dictionary_event_script.init(event_id)
#	dictionary_event.event_id = event_id
#	dictionary_event.info_dictionary = info_dictionary
#	return dictionary_event
	

func _init(event_id, info_dictionary).(event_id):
	self.info_dictionary = info_dictionary

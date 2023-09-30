extends Label

func _ready():
	EventServices.dispatch().subscribe(RedSprite.EVENT_ID, self, "_on_red_event")
	
	
func _on_red_event(event: Event):
	var dict_event := event as DictionaryEvent
	if not dict_event:
		return
		
	var remaining_event_count = dict_event.info_dictionary[RedSprite.EVENT_KEY_COUNT]
	_update(remaining_event_count)
	
	
func _update(remainig_events: int):
	if remainig_events > 0:
		self.text = "RED EVENTS REMAINING: " + str(remainig_events)
	else:
		self.text = "RED IS COOKED"

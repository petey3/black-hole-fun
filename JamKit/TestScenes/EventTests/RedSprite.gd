extends Sprite
class_name RedSprite

const EVENT_ID = "red_event"
const EVENT_KEY_COUNT = "remaining_event_count"

var events_remaining = 5

func _ready():
	EventServices.dispatch().subscribe(GreenEvent.ID, self, "_on_green_event")
	var inline_timer = InlineTimer.wait(self, 0.1)
	yield(inline_timer.timer, inline_timer.timeout)
	_send_event()


func _on_green_event(event: Event):
	print("RED GOT EVENT")
	events_remaining -= 1
	print("RED HAS " + str(events_remaining) + " events remaining")
	_send_event()
	
	if events_remaining <= 0:
		print("RED GO BYE BYE")
		call_deferred("queue_free")
		
		
func _send_event():
	var info_dictionary = Dictionary()
	info_dictionary[EVENT_KEY_COUNT] = events_remaining
	var dictionary_event = DictionaryEvent.new(EVENT_ID, info_dictionary)
	EventServices.dispatch().broadcast(dictionary_event)

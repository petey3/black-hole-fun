extends Sprite
class_name PurpleSprite

const EVENT_ID = "purple_event"
const EVENT_KEY_SCALE = "scale"

func _ready():
	EventServices.dispatch().subscribe("green_event", self, "_on_green_event")


func _on_green_event(event: Event):
	print("PURPLE GOT EVENT")
	var info_dictionary = Dictionary()
	info_dictionary[EVENT_KEY_SCALE] = Vector2(Random.randf_range(0.5, 3.5), Random.randf_range(0.5, 3.5))
	var dict_event = DictionaryEvent.new(EVENT_ID, info_dictionary)
	EventServices.dispatch().broadcast(dict_event)

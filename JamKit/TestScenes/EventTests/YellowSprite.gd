extends Sprite
# YellowSprite

onready var feedback_runner = $FeedbackRunner as FeedbackRunner
onready var scale_feedback = $FeedbackRunner/ScaleFeedback2D as ScaleFeedback2D

func _ready():
	EventServices.dispatch().subscribe(PurpleSprite.EVENT_ID, self, "_on_purple_event")


func _on_purple_event(event: Event):
	var dict_event := event as DictionaryEvent
	if not dict_event:
		print("YELLOW GOT UNKNOWN EVENT")
		
	print("YELLOW GOT PURPLE'S DICT EVENT")
	var event_scale = dict_event.info_dictionary[PurpleSprite.EVENT_KEY_SCALE]
	scale_feedback.scale_change = event_scale
	feedback_runner.execute_feedbacks()
	

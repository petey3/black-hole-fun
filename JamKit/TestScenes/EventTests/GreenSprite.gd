extends Sprite
# GreenSprite

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var green_event = GreenEvent.new()
		EventServices.dispatch().broadcast(green_event)

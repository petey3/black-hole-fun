extends Node2D
# We dont extend Level here because we dont want the typical level registration

func _on_ReturnToTitleButton_pressed():
	PresentationServices.context_service.handle_transition_request(TitleContext.CONTEXT_ID)

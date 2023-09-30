extends Context

const PopupScene = preload("res://TestScenes/PresentationTest/UIScreens/RandomColorOverlay.tscn")

onready var color_rect = $ColorRect

func context_id_string() -> String:
	return "context.title"
	

func _ready():
	PresentationServices.ui_service.set_root_control(color_rect)
	

func present_random_color_overlay():
	var random_color_popup = PopupScene.instance() as RandomColorOverlay
	random_color_popup.connect("dismiss_requested", self, "_on_dismiss_requested")
	random_color_popup.connect("present_new_requested", self, "_on_present_new_requested")
	PresentationServices.ui_service.present_ui(random_color_popup)


func _on_go_to_game_pressed():
	change_context("gameplay")


func _on_display_popup_pressed():
	present_random_color_overlay()


func _on_present_new_requested():
	present_random_color_overlay()


func _on_dismiss_requested():
	PresentationServices.ui_service.dismiss_top_ui()

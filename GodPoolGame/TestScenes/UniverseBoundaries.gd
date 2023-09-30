extends Node2D
class_name UniverseBoundaries
# The class responsible for mananging
# the boundaries of the universe the game is played
# inside of 

export (float, 0.1, 1) var boundary_scale = 1 

onready var camera = $Camera2D

onready var universe_root = $UniverseRoot

onready var top_half = $UniverseRoot/TopHalf
onready var top_half_shape = $UniverseRoot/TopHalf/CollisionPolygon2D
onready var bottom_half = $UniverseRoot/BottomHalf
onready var bottom_half_shape = $UniverseRoot/BottomHalf/CollisionPolygon2D

onready var feedback_runner = $FeedbackRunner
onready var scale_feedback = $FeedbackRunner/ScaleFeedback2D
onready var transform_feedback = $FeedbackRunner/TransformFeedback2D

var universe_center = Vector2.ZERO

func _ready():
	universe_center = get_viewport_rect().size / 2
	camera.position = universe_center
	camera.current = true
	_print()
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_set_boundary_scale(universe_root.scale.x - 0.1)


func _print():
	print("TOP POINTS")
	_print_points_for_polygon(top_half_shape, top_half.position)
	print("BOTTOM POINTS")
	_print_points_for_polygon(bottom_half_shape, bottom_half.position)

	
func _print_points_for_polygon(collision_polygon: CollisionPolygon2D, origin_offset: Vector2):
	var vector_array = collision_polygon.polygon
	for vector in vector_array:
		if not _is_point_along_viewport_edge(vector, origin_offset):
			print(str(vector + origin_offset))
			
			
func _is_point_along_viewport_edge(point: Vector2, origin_offset: Vector2) -> bool:
	var viewport_rect = get_viewport_rect()
	var offset_point = point + origin_offset
	var top_left = viewport_rect.position
	var top_right = 	Vector2(viewport_rect.size.x, viewport_rect.position.y)
	var bottom_right = viewport_rect.position + viewport_rect.size
	var bottom_left = Vector2(viewport_rect.position.x, viewport_rect.position.y + viewport_rect.size.y)
	var points_to_check = [top_left, top_right, bottom_right, bottom_left]
	for point_to_check in points_to_check:
		var is_x_too_close = _is_within_padding(point.x, point_to_check.x, 10)
		var is_y_too_close = _is_within_padding(point.y, point_to_check.y, 10)
		if is_x_too_close or is_y_too_close:
			return true
		
	return false
	
func _is_within_padding(value: int, precise_boundary: int, padding: int) -> bool:
	var greater_than_min = value > precise_boundary - padding
	var less_than_max = value < precise_boundary + padding
	return greater_than_min and less_than_max


func _set_boundary_scale(new_scale: float):
	var new_scale_vector = Vector2(new_scale, new_scale)
	scale_feedback.scale_change = new_scale_vector
	var full_rect_size = get_viewport_rect().size
	var scaled_rect_size = full_rect_size * new_scale
	var size_delta = Vector2(full_rect_size.x - scaled_rect_size.x, full_rect_size.y - scaled_rect_size.y)
	transform_feedback.position_change = size_delta / 2
	
	feedback_runner.execute_feedbacks()
	var inline_timer = InlineTimer.wait(self, 1)
	yield(inline_timer.timer, inline_timer.timeout)
	
	var tween = create_tween()
	tween.tween_property(camera, "zoom", new_scale_vector, 1)

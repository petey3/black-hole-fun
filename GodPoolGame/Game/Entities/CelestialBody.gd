extends RigidBody2D
class_name CelestialBody

onready var collision_shape = $CollisionShape2D
onready var sprite = $Sprite

func _ready():
	_add_to_groups()

func _add_to_groups():
	add_to_group(GodPoolGameConstants.GROUP_ID_CELESTIAL_BODY)
	add_to_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_MOVEABLE)

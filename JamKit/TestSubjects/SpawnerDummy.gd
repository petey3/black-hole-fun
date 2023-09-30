extends Node2D
class_name SpawnerDummy

onready var toggle_sequencer = $ToggleSequencer
onready var sprite = $Sprite
onready var spawner = $Sprite/Spawner2D
onready var spawn_parent = $SpawnParent

func _ready():
	toggle_sequencer.connect("new_value", self, "_on_toggle")
	spawner.parent_for_spawn = spawn_parent
	spawner.connect("node_spawned", self, "_on_node_spawned")
	yield(get_tree().create_timer(0.5), "timeout")
	spawner.spawn()
	
	
func _on_toggle(_value: bool):
	spawner.spawn()
	

func _on_node_spawned(node: Node2D):
	var spawnable_dummy = node as SpawnableDummy
	if not spawnable_dummy:
		return
	
	var new_position = node.position + Vector2(Random.randf_range(-30, 30),  Random.randf_range(-30, 30))
	var new_scale = node.scale * Vector2(Random.randf_range(0.7, 1.3), Random.randf_range(0.7, 1.3))
	var new_rotation_degrees = Random.randf_range(0, 360)
	
	spawnable_dummy.life_time = 3
	spawnable_dummy.set_with_transforms(new_position, new_scale, new_rotation_degrees)
#
#	print(node.name)
#	print(node.position)
#	print(node.scale)
#	print(node.rotation_degrees)



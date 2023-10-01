extends CelestialBody
class_name Planet

export (int) var population = 0 setget _set_population

func _ready():
	randomize()
	var bases = [
		preload("res://Assets/Planets/Base/plain.png"),
		preload("res://Assets/Planets/Base/lumpy.png"),
		preload("res://Assets/Planets/Base/spike.png"),
		preload("res://Assets/Planets/Base/disco.png"),
		preload("res://Assets/Planets/Base/super.png"),
	]
	var effects = [
		preload("res://Assets/Planets/Effects/bubble.png"),
		preload("res://Assets/Planets/Effects/clouds.png"),
		preload("res://Assets/Planets/Effects/goopy.png"),
		preload("res://Assets/Planets/Effects/ring-moon.png"),
		preload("res://Assets/Planets/Effects/squiggles.png"),
		preload("res://Assets/Planets/Effects/vine.png"),
	]
	var faces = [
		preload("res://Assets/Planets/Faces/grin.png"),
		preload("res://Assets/Planets/Faces/hyper.png"),
		preload("res://Assets/Planets/Faces/mellow.png"),
		preload("res://Assets/Planets/Faces/oh.png"),
		preload("res://Assets/Planets/Faces/stinker.png"),
	]
	$Sprite.texture = bases[randi() % 5]
	$Sprite/Effect.texture = effects[randi() % 5]
	$Sprite/Face.texture = faces[randi() % 5]
	
	if population == 0:
		$Sprite/Face.visible = false

func has_life() -> bool:
	return population > 0


func _set_population(p):
	population = p
	if $Sprite/Face == null:
		return
	
	if population == 0:
		$Sprite/Face.visible = false
	else:
		$Sprite/Face.visible = true


func _add_to_groups():
	._add_to_groups()
	add_to_group(GodPoolGameConstants.GROUP_ID_PLANET)
	add_to_group(GodPoolGameConstants.GROUP_ID_BLACKHOLE_SWALLOWABLE)
	add_to_group(GodPoolGameConstants.GROUP_ID_VOID_SWALLOWABLE)
	add_to_group(GodPoolGameConstants.GROUP_ID_WHITE_HOLE_CAPTURABLE)


func _on_void_destroy():
	var void_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.VOID, population)
	EventServices.dispatch().broadcast(void_event)
	._on_void_destroy()


func _on_swallowed_by_blackhole():
	var blackhole_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.BLACKHOLE, population)
	EventServices.dispatch().broadcast(blackhole_event)
	._on_swallowed_by_blackhole()


func _on_collide_with_whitehole():
	var whitehole_event = PlanetChangeEvent.new(PlanetChangeEvent.ChangeType.WHITEHOLE, population)
	EventServices.dispatch().broadcast(whitehole_event)
	._on_collide_with_whitehole()

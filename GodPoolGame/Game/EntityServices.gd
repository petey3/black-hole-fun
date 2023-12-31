extends Node
class_name EntityServices

var current_level: Level = null

func register_current_level(level: Level):
	clear_registered_level()
	var level_entity_info = create_level_info()
	level.level_entity_info = level_entity_info
	self.current_level = level


func create_level_info() -> LevelEntityInfo:
	var starting_live_planets = remaining_live_planet_count()
	var starting_dead_planets = remaining_dead_planet_count()
	
	print("REGISTERING NEW LEVEL")
	print("Starting Planets: " + str(starting_live_planets))
	
	var level_entity_info = LevelEntityInfo.new(starting_live_planets, starting_dead_planets)
	EventServices.dispatch().subscribe(PlanetChangeEvent.ID, self, "_on_planet_change_event")
	EventServices.dispatch().subscribe(ReloadedCurrentSceneEvent.ID, self, "_on_reloaded_scene_event")

	return level_entity_info
	
	
func get_level_entity_info() -> LevelEntityInfo:
	if not current_level or not is_instance_valid(current_level):
		current_level = null
		return null
		
	return current_level.level_entity_info
	
	
func clear_registered_level():
	current_level = null


func _on_planet_change_event(event: Event):
	var change_event := event as PlanetChangeEvent
	if not change_event:
		return
		
	if change_event.population == 0:
		return
		
	match change_event.change_type:
		PlanetChangeEvent.ChangeType.VOID:
			print("Lost to the void")			
			if not get_level_entity_info():
				return
			current_level.level_entity_info.lost_live_planet_count += 1
		PlanetChangeEvent.ChangeType.BLACKHOLE:
			print("Lost to the blackhole")
			if not get_level_entity_info():
				return
			current_level.level_entity_info.lost_live_planet_count += 1
		PlanetChangeEvent.ChangeType.WHITEHOLE:
			print("Saved by the whitehole")
			if not get_level_entity_info():
				return
			current_level.level_entity_info.saved_live_planet_count += 1


func _on_reloaded_scene_event(event: Event):
	clear_registered_level()


func get_all_planets() -> Array:
	return get_tree().get_nodes_in_group(GodPoolGameConstants.GROUP_ID_PLANET)
	
	
func total_remaining_planet_count() -> int:
	return get_all_planets().size()
	

func remaining_live_planet_count() -> int:
	var all_planets = get_all_planets()
	var live_planets = []
	for planet in all_planets:
		var p := planet as Planet
		if not p:
			continue
			
		if p.has_life():
			live_planets.append(p)
			
	return live_planets.size()
		
	
func remaining_dead_planet_count() -> int:
	var all_planets = get_all_planets()
	var dead_planets = []
	for planet in all_planets:
		var p := planet as Planet
		if not p:
			continue
			
		if not p.has_life():
			dead_planets.append(p)
			
	return dead_planets.size()
	

func are_bodies_still_moving() -> bool:
	var celestial_bodies = get_tree().get_nodes_in_group(GodPoolGameConstants.GROUP_ID_CELESTIAL_BODY)
	
	for body in celestial_bodies:
		var rigid_body := body as RigidBody2D
		if not rigid_body:
			continue
			
		if rigid_body.linear_velocity.length() > 15:
#			print(rigid_body.name + " is moving: " + str(rigid_body.linear_velocity.length()))
			return true
		else:
			#  force clamp
			rigid_body.linear_velocity = Vector2.ZERO
			
	
	return false
	
	
func saved_live_planets() -> int:
	if not get_level_entity_info():
		return 0
		
	return current_level.level_entity_info.saved_live_planet_count
	
	
func lost_live_planets() -> int:
	if not get_level_entity_info():
		return 0
		
	return current_level.level_entity_info.lost_live_planet_count
	
	
func are_all_live_planets_lost() -> bool:
	if not get_level_entity_info():
		return false
		
	var none_were_saved = saved_live_planets() == 0
	var none_are_left = total_remaining_planet_count() == 0
	return none_were_saved && none_are_left
	
	
func are_all_live_planets_saved() -> bool:
	if not get_level_entity_info():
		return false
		
	print("Saved Live Planets " + str(saved_live_planets()))
	print("Starting Live Planets " + str(current_level.level_entity_info.starting_live_planet_count))
	return saved_live_planets() == current_level.level_entity_info.starting_live_planet_count
	

extends Node2D
class_name WhiteHole
# Entity that collects other planets (good)

signal planet_saved()

func _ready():
	pass
	

func _on_collection_area_entered(area):
	# TODO: check if the area belongs to a planet
	pass # Replace with function body.

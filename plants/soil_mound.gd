extends Node3D
class_name SoilMound

@onready var plant_spawn_point: Marker3D = $"PlantSpawnPoint"

var current_plant: Plant = null

func interact(_player, item) -> bool:
	if current_plant != null:
		print("Already planted")
		return false
		
	if item == null or not (item is SeedItemData):
		print("Not a seed")
		return false
		
	var seed_item: SeedItemData = item
	
	var plant: Plant = seed_item.create_plant()
	plant.global_position = plant_spawn_point.global_position
	
	get_tree().current_scene.add_child(plant)
	current_plant = plant
	plant.harvested.connect(_on_plant_harvested)
	return true
	
func _on_plant_harvested():
	current_plant = null

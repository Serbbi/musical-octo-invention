extends Node3D
class_name SoilMound

@onready var plant_spawn_point: Marker3D = $"PlantSpawnPoint"
@onready var cube: MeshInstance3D = $Cube

var current_plant: Plant = null
var watered: bool = false

func interact(_player, item) -> bool:
	if current_plant != null:
		print("Already planted")
		return false
	
	if item == null:
		return false
	
	if item is SeedItemData:
		return plant_item(item)
		
	if item.name == "Watering Can":
		return water()
		
	return false

func _on_plant_harvested():
	current_plant = null
	watered = false
	var material: StandardMaterial3D = cube.get_surface_override_material(0)
	material.albedo_color = Color(0.431, 0.271, 0.188)
	cube.set_surface_override_material(0, material)
	
func water() -> bool:
	watered = true
	var material: StandardMaterial3D = cube.get_surface_override_material(0)
	material.albedo_color = Color(0.283, 0.17, 0.111, 1.0)
	cube.set_surface_override_material(0, material)
	
	if current_plant:
		current_plant.plant_data.growth_time /= 2
	
	return false

func plant_item(item) -> bool:
	var seed_item: SeedItemData = item
	
	var plant: Plant = seed_item.create_plant()
	plant.global_position = plant_spawn_point.global_position
	
	# Set growth speed based on watered
	if watered:
		plant.plant_data.growth_time /= 2
	
	get_tree().current_scene.add_child(plant)
	current_plant = plant
	plant.harvested.connect(_on_plant_harvested)
	return true

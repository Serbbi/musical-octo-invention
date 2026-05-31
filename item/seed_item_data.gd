extends ItemData
class_name SeedItemData

@export var plant_scene: PackedScene

func create_plant() -> Plant:
	return plant_scene.instantiate() as Plant

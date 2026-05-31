class_name Plant
extends Node3D

signal harvested

@export var plant_data: PlantData

@onready var stages = $Stages.get_children()

var current_stage: int = 0

func _ready() -> void:
	while current_stage < stages.size() - 1:
		await get_tree().create_timer(plant_data.growth_time).timeout
		current_stage += 1
		update_visual()
		
func update_visual():
	for i in range(stages.size()):
		stages[i].visible = (i == current_stage)

func is_fully_grown() -> bool:
	return current_stage >= stages.size() - 1

func interact(player, _item):
	if !is_fully_grown():
		print("Not ready yet")
		return
	
	harvest(player)
	
func harvest(player):
	print("Harvested!")
	harvested.emit()
	
	player.inventory_data.add_item(plant_data.harvest_item, plant_data.harvest_amount)
	
	queue_free()

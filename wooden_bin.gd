extends StaticBody3D

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData

func interact(_player, _item) -> bool:
	toggle_inventory.emit(self)
	return false

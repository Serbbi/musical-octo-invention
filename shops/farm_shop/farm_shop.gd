extends Node
class_name FarmShop

signal interacted

@export var shop_data: ShopData

func interact(_player, _item) -> bool:
	interacted.emit()
	return false

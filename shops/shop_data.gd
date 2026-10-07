extends Resource
class_name ShopData

@export var slot_datas: Array[SlotData]

func buy_item(index: int) -> ItemData:
	return slot_datas[index].item_data

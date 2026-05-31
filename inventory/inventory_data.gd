extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int)

@export var slot_datas: Array[SlotData]

func grab_slot_data(index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	if slot_data:
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	
	return null

func grab_single_slot_data(index: int) -> SlotData:
	var slot_data = slot_datas[index]
	var return_slot_data: SlotData
	
	if slot_data:
		if slot_data.quantity > 1:
			return_slot_data = slot_data.create_single_slot_data()
		else:
			slot_datas[index] = null
			return_slot_data = slot_data
		inventory_updated.emit(self)
	
	return return_slot_data

func drop_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slot_datas[index]
	var return_slot_data: SlotData
	
	if slot_data and slot_data.can_fully_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data)
	else:
		slot_datas[index] = grabbed_slot_data
		return_slot_data = slot_data
	
	inventory_updated.emit(self)
	return return_slot_data

func drop_single_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	if not slot_data:
		slot_datas[index] = grabbed_slot_data.create_single_slot_data()
	elif slot_data.can_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data.create_single_slot_data())
		
	inventory_updated.emit(self)
	
	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else:
		return null

func on_slot_clicked(index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)
	
func add_item(item: ItemData, amount: int) -> void:
	if !item.stackable:
		add_item_new_slot(item, amount)
	else:
		var inv_slot: SlotData = null
		for slot in slot_datas:
			if slot and slot.item_data.name == item.name:
				inv_slot = slot
				break
		if !inv_slot:
			add_item_new_slot(item, amount)
		else:
			inv_slot.quantity += amount
			inventory_updated.emit(self)

func add_item_new_slot(item: ItemData, amount: int) -> void:
	var free_index = 0
	for slot in slot_datas:
		if slot:
			free_index += 1
		else:
			break
	
	var slot_data = SlotData.new()
	slot_data.item_data = item
	slot_data.quantity = amount
	slot_datas[free_index] = slot_data
	inventory_updated.emit(self)

func remove_item(index: int, amount: int = 1) -> bool:
	var slot = slot_datas[index]
	
	if slot == null or slot.quantity < amount:
		return false
	
	slot.quantity -= amount
	
	if slot.quantity == 0:
		slot_datas[index] = null
		
	inventory_updated.emit(self)
	return true

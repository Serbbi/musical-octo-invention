extends StaticBody3D

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData

func interact(_player, _item) -> bool:
	toggle_inventory.emit(self)
	return false

func sell_inventory(player) -> void:
	for idx in inventory_data.slot_datas.size():
		var slot = inventory_data.slot_datas[idx]
		if slot:
			var item = slot.item_data
			#player.coins += item.selling_price * slot.quantity
			player.set_player_coins(item.selling_price * slot.quantity)
			print("Player has ", player.coins, " coins after selling ", item.name)
			inventory_data.remove_item(idx, slot.quantity)

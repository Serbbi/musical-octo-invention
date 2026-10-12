extends PanelContainer

signal hot_bar_select(index: int)

const Slot = preload("res://inventory/slot.tscn")

@onready var h_box_container: HBoxContainer = $MarginContainer/HBoxContainer

var selected_index: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if visible and event is InputEventKey and event.is_pressed():
		if range(KEY_1, KEY_7).has(event.keycode):
			selected_index = event.keycode - KEY_1
			hot_bar_select.emit(event.keycode - KEY_1)
			update_selection_visual()

func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_hot_bar)
	populate_hot_bar(inventory_data)
	

func populate_hot_bar(inventory_data: InventoryData) -> void:
	for child in h_box_container.get_children():
		h_box_container.remove_child(child)
		child.queue_free()
		
	for slot_data in inventory_data.slot_datas.slice(0, 6):
		var slot = Slot.instantiate()
		h_box_container.add_child(slot)
				
		if slot_data:
			slot.set_slot_data(slot_data)
	
	update_selection_visual()

func update_selection_visual():
	for i in range(h_box_container.get_child_count()):
		var slot: PanelContainer = h_box_container.get_child(i)
		
		if i == selected_index:
			slot.get_theme_stylebox("panel").bg_color = Color(0.444, 0.432, 0.432, 1.0)
		else:
			slot.get_theme_stylebox("panel").bg_color = Color(0.251, 0.243, 0.243)

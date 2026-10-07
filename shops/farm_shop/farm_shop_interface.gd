extends PanelContainer

const Slot = preload("res://inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
var shop_data: ShopData

signal open_ui(ui: Control)
signal close_ui(ui: Control)
signal item_selected(item_data: ItemData)

func populate_item_grid(data: ShopData) -> void:
	shop_data = data
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in shop_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(_on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)

func _on_slot_clicked(index: int, button: int):
	if button != MOUSE_BUTTON_LEFT:
		return
	if shop_data.slot_datas[index] == null:
		return
	item_selected.emit(shop_data.buy_item(index))

func _on_button_pressed() -> void:
	close_ui.emit(self)

func _on_shop_interacted() -> void:
	open_ui.emit(self)

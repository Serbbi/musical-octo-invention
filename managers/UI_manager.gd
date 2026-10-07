extends Node
class_name UIManager

@onready var farm_shop_inventory_interface: Control = $"../UI/FarmShopInterface"
@onready var farm_shop: Node3D = $"../Farm_Shop"

var player: CharacterBody3D
var uis: Array[Control] = []

func _ready() -> void:
	farm_shop_init()

func on_ui_open(ui: Control) -> void:
	player.release_mouse()
	ui.show()

func on_ui_closed(ui: Control) -> void:
	player.capture_mouse()
	ui.hide()

func farm_shop_init() -> void:
	farm_shop_inventory_interface.populate_item_grid(farm_shop.shop_data)
	farm_shop.interacted.connect(farm_shop_inventory_interface._on_shop_interacted)
	farm_shop_inventory_interface.open_ui.connect(on_ui_open)
	farm_shop_inventory_interface.close_ui.connect(on_ui_closed)
	farm_shop_inventory_interface.item_selected.connect(_on_shop_item_selected)

func _on_shop_item_selected(item_data):
	if player:
		player.inventory_data.add_item(item_data, 1)

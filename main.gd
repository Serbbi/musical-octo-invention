extends Node3D

@onready var player: CharacterBody3D = $ProtoController
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var hot_bar_inventory: PanelContainer = $UI/HotBarInventory
@onready var ui_manager: Node = $UIManager

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	hot_bar_inventory.set_inventory_data(player.inventory_data)
	ui_manager.player = player

func toggle_inventory_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	
	if inventory_interface.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		hot_bar_inventory.hide()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hot_bar_inventory.show()

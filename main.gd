extends Node3D

@onready var player: CharacterBody3D = $ProtoController
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var hot_bar_inventory: PanelContainer = $UI/HotBarInventory
@onready var ui_manager: Node = $UIManager

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	hot_bar_inventory.set_inventory_data(player.inventory_data)
	ui_manager.setup(player)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func toggle_inventory_interface(external_inventory_owner = null) -> void:
	inventory_interface.visible = not inventory_interface.visible
	
	if inventory_interface.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		hot_bar_inventory.hide()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hot_bar_inventory.show()
		
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory_owner(external_inventory_owner)
	else:
		if inventory_interface.external_inventory_owner and inventory_interface.external_inventory_owner.has_method("sell_inventory"):
			inventory_interface.external_inventory_owner.sell_inventory(player)
		inventory_interface.clear_external_inventory_owner()

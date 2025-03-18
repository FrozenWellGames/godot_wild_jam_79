extends Node


var inventory = []

@onready var inventory_slot_scene = preload("res://Game/Inventory/inventory_slot.tscn")

func _ready() -> void:
	inventory.resize(12)

func add_item(item) -> bool:
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["name"] == item["name"]:
			inventory[i]["quantity"] += item["quantity"]
			SignalManager.emit_signal("inventory_updated")
			return true
		elif inventory[i] == null:
			inventory[i] = item
			SignalManager.emit_signal("inventory_updated")
			return true
	return false

func remove_item() -> void:
	SignalManager.emit_signal("inventory_updated")

func increase_inventory_size() -> void:
	SignalManager.emit_signal("inventory_updated")

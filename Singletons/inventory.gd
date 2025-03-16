extends Node


var inventory = []

func _ready() -> void:
	inventory.resize(10)

func add_item() -> void:
	SignalManager.emit_signal("inventory_updated")

func remove_item() -> void:
	SignalManager.emit_signal("inventory_updated")

func increase_inventory_size() -> void:
	SignalManager.emit_signal("inventory_updated")

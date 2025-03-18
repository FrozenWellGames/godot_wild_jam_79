extends Node2D

@onready var inventory_ui = $InventoryUI


func _process(_delta: float) -> void:
	ui_input()

func ui_input() -> void:
	if Input.is_action_just_pressed("ui_inventory"):
		toggle_inventory_ui_visibility()


func toggle_inventory_ui_visibility() -> void:
	inventory_ui.visible = !inventory_ui.visible
	get_tree().paused = !get_tree().paused

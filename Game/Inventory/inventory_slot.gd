extends Control

@onready var icon = $OuterRect/InnerRect/ItemIcon
@onready var quantity_label = $OuterRect/InnerRect/QuantityLabel
@onready var usage_panel = $OuterRect/UsagePanel

var item = null


func _on_item_button_pressed() -> void:
	if item != null:
		usage_panel.visible = !usage_panel.visible


func set_empty() -> void:
	icon.texture = null
	quantity_label.text = ""


func set_item(new_item) -> void:
	item = new_item
	icon.texture = new_item["texture"]
	quantity_label.text = str(new_item["quantity"])

@tool
extends Node2D

@export_subgroup("Settings")
@export  var item_type:String = ""
@export var item_name: String = ""
@export  var item_textture: Texture
@export var item_effect: String = ""
var scene_path: String = "res://Game/MiningScene/InventoryItem/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D


func _ready() -> void:
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_textture


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		icon_sprite.texture = item_textture

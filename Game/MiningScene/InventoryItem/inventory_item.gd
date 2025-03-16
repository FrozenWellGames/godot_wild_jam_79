@tool
extends Node2D

@export_subgroup("Settings")
@export  var item_type:String = ""
@export var item_name: String = ""
@export  var item_texture: Texture
@export var item_effect: String = ""
var scene_path: String = "res://Game/MiningScene/InventoryItem/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D

var player_is_overlapping:bool = false


func _ready() -> void:
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture
	if player_is_overlapping and Input.is_action_just_pressed("ui_inventory_add"):
		pick_up_item()
		
func pick_up_item() -> void:
	var item = {
		"quantity":1,
		"type": item_type,
		"name": item_name,
		"texture": item_texture,
		"scene_path": scene_path
	}
	if GameManager.player_node:
		Inventory.add_item(item)
		queue_free()


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		player_is_overlapping = true


func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		player_is_overlapping = false

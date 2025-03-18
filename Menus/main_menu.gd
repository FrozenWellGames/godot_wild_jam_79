extends Node2D

func _ready() -> void:
	SignalManager.emit_signal("inventory_updated")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		_on_Button_pressed()


func _on_Button_pressed():
	get_tree().change_scene_to_file("res://Game/HomeScene/home.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/MiningScene/mining_scene.tscn")


func _on_settings_button_pressed() -> void:
	print("Settings Button Pressed")

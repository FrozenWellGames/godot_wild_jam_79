extends Node2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		_on_Button_pressed()

func _on_Button_pressed():
	get_tree().change_scene_to_file("res://Game/game.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/game.tscn")


func _on_settings_button_pressed() -> void:
	print("Settings Button Pressed")

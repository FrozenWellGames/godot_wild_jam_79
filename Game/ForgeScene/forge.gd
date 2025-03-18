extends Node2D


var player_is_overlapping : bool = false


func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_up") and player_is_overlapping:
		get_tree().change_scene_to_file("res://Game/HomeScene/home.tscn")


func _on_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_is_overlapping = true


func _on_door_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_is_overlapping = false

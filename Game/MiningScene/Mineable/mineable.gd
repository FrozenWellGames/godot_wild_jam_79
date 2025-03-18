extends Area2D

var health: int


func _ready() -> void:
	health = 5


func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "WeaponHitbox":
		health -= 1
	if health == 0:
		queue_free()

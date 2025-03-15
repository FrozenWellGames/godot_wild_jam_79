extends AnimationPlayer

enum states {PLATFORM, LADDER, MINING}

func player_animations(IsOnFloor: bool, state, velocity: Vector2, sprite: Sprite2D) -> void:
	if state == states.PLATFORM:
		if IsOnFloor:
			if velocity.x == 0:
				play("idle")
			elif velocity.x < 0:
				sprite.scale.x = -1
				play("run")
			elif velocity.x > 0:
				sprite.scale.x = 1
				play("run")
		if !IsOnFloor:
			if velocity.y < 0:
				play("jump")
			elif velocity.y > 0:
				play("fall")
			if velocity.x < 0:
				sprite.scale.x = -1
			if velocity.x > 0:
				sprite.scale.x = 1
	elif state == states.LADDER:
		if velocity.y == 0:
			super.stop()
		elif velocity.y != 0:
			play("climb")
	elif state == states.MINING:
		play("mine")

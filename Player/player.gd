extends CharacterBody2D

var run_speed: int = 70
var climb_speed: int = 40
var jump_speed: int = -150
var gravity: int = 800
var is_ovelapping_ladder: bool = false
var is_ovelapping_ladder_top: bool = false
enum states {PLATFORM, LADDER, MINING}
var state


func _ready():
	GameManager.set_player_reference(self)
	state = states.PLATFORM
	$Sprite2D/WeaponHitbox/CollisionShape2D.disabled = true


func _physics_process(delta):
		if state == states.MINING:
			pass
		elif state == states.PLATFORM:
			get_input_platform()
			velocity.y += gravity * delta
			set_up_direction(Vector2(0, -1))
			move_and_slide()
			velocity = velocity
		elif state == states.LADDER:
			get_input_ladder()
			set_up_direction(Vector2(0, -1))
			move_and_slide()
			velocity = velocity
		set_velocity(velocity)
		$AnimationPlayer.player_animations(is_on_floor(), state, velocity, $Sprite2D)
		if !is_ovelapping_ladder and state != states.MINING:
			state = states.PLATFORM


func get_input_platform() -> void:
	if Input.is_action_pressed("action") and is_on_floor() or state == states.MINING:
		state = states.MINING
		velocity.x = 0
	else: # state != states.MINING:
		#left right movement
		velocity.x = Input.get_axis("move_left", "move_right") * run_speed
		#jump
		var jump = Input.is_action_just_pressed("jump")
		if jump and is_on_floor() and state == states.PLATFORM:
			velocity.y = jump_speed
		# capture up & down to use in changing to ladder state
		var YInput: float = Input.get_axis("move_up", "move_down") * climb_speed
		if is_ovelapping_ladder and YInput < 0:
			state = states.LADDER
		if is_ovelapping_ladder_top and is_on_floor() and YInput > 0:
			state = states.LADDER
			position.y += 1
			is_ovelapping_ladder = true
		
	
func get_input_ladder() -> void:
	velocity = Vector2.ZERO
	#left right movement
	velocity.x = Input.get_axis("move_left", "move_right") * climb_speed
	# up down movement
	velocity.y = Input.get_axis("move_up", "move_down") * climb_speed
	if is_on_floor() and state != states.MINING:
		state = states.PLATFORM


func _on_area_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("ladder"):
		is_ovelapping_ladder = true
	if area.is_in_group("ladder_top"):
		is_ovelapping_ladder_top = true


func _on_area_detector_area_exited(area: Area2D) -> void:
	if area.is_in_group("ladder"):
		is_ovelapping_ladder = false
	if area.is_in_group("ladder_top"):
		is_ovelapping_ladder_top = false

func leave_mining_state() -> void:
	state = states.PLATFORM

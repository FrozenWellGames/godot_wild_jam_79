extends CharacterBody2D

var run_speed: int = 70
var climb_speed: int = 40
var jump_speed: int = -150
var gravity: int = 800
var is_ovelapping_ladder: bool = false
var is_ovelapping_ladder_top: bool = false
var is_ovelapping_repairable: bool = false
enum states {PLATFORM, LADDER, FIXING}
var state


func _ready():
	state = states.PLATFORM


func _physics_process(delta):
	if state == states.PLATFORM:
		get_input_platform()
		velocity.y += gravity * delta
		set_velocity(velocity)
		set_up_direction(Vector2(0, -1))
		move_and_slide()
		velocity = velocity
	if state == states.LADDER:
		get_input_ladder()
		set_velocity(velocity)
		set_up_direction(Vector2(0, -1))
		move_and_slide()
		velocity = velocity
	$AnimationPlayer.player_animations(is_on_floor(), state, velocity, $Sprite2D)
	if !is_ovelapping_ladder:
		state = states.PLATFORM


func get_input_platform() -> void:
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
	var actionPressed = Input.is_action_pressed("action")
	if actionPressed and is_ovelapping_repairable:
		state = states.FIXING


func get_input_ladder() -> void:
	velocity = Vector2.ZERO
	#left right movement
	velocity.x = Input.get_axis("move_left", "move_right") * climb_speed
	# up down movement
	velocity.y = Input.get_axis("move_up", "move_down") * climb_speed
	if is_on_floor():
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

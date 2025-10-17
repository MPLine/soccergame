class_name PlayerStateMoving 
extends PlayerState
@export var move_speed = 1.5

func _physics_process(delta: float) -> void:
	
	if player.is_AI:
		AI_Behavoir._process_ai(delta)
	else:
		
		handle_movement(delta)
	player.move_and_slide()
func handle_movement(delta):
	var input_dir = Vector3.ZERO
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")


	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized()
		player.velocity.x = input_dir.x * move_speed
		player.velocity.z = input_dir.z * move_speed
		
		player.look_at(player.global_position + input_dir, Vector3.UP)
	else:
		player.velocity = Vector3.ZERO
		
	if player.velocity != Vector3.ZERO and  not player.is_possession and player.shoot.is_pressed():
		state_transition_requested.emit(Player.States.TACKLING)
	
	if player.has_ball() and player.is_possession and player.pas.is_pressed():
		state_transition_requested.emit(player.States.PASSING)
		
	if player.has_ball() and player.is_possession and player.shoot.is_pressed():
		state_transition_requested.emit(player.States.SHOOTING)
	 

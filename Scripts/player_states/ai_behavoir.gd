class_name AIBehavoir
extends Node
const AI_TICK_FREKENCY :=200
var ball: Ball = null
var player : Player =null
var AI_time_stick:= Time.get_ticks_msec()
var states = PlayerState.new()
func _ready() -> void:
	var AI_time_stick:= Time.get_ticks_msec() + randi_range(0,AI_TICK_FREKENCY)
	
func setup(context_player : Player, context_ball : Ball)-> void:
	player = context_player
	ball = context_ball
	
func _process_ai(delta)->void:
	#if Time.get_ticks_msec() - AI_time_stick> AI_TICK_FREKENCY:
		AI_time_stick = Time.get_ticks_msec()
		ai_movement(delta)
		ai_decision()
	
func ai_decision()->void:

	pass
	
func ai_movement(delta)->void:
	if player.distance_check() and player.AI_speed >20:
		var moving = Vector3.ZERO
		if player.is_possession:
			moving  += player.position.direction_to(player.goal_target.position) 
			player.look_at(player.goal_target.position,Vector3.UP)
		else:
			moving  += player.position.direction_to(ball.position) 
		moving = moving.limit_length(1.0)
		player.velocity = moving * player.AI_speed * delta
		player.move_and_slide()
	else:
		player.velocity = Vector3.ZERO
		states.state_transition_requested.emit(player.States.SHOOTING)
		pass
	pass

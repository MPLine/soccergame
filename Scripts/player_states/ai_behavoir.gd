class_name AIBehavoir
extends Node
const AI_TICK_FREKENCY :=200
var ball: Ball = null
var player : Player =null
var AI_time_stick:= Time.get_ticks_msec()
var direction
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
	var total_steering_force := Vector3.ZERO
	total_steering_force += get_onduty_streering_force()
	total_steering_force = total_steering_force.limit_length(1.0)
	player.velocity = total_steering_force * player.speed
	pass

func get_onduty_streering_force()->Vector3:
	
	if player.is_possession:
		direction = player.weight_on_duty_sterring * player.position.direction_to(player.goal_target.position)
		player.look_at(player.goal_target.position)
	else:
		direction = player.weight_on_duty_sterring * player.position.direction_to(ball.position)
		
	return direction

class_name AIBehavoir
extends Node

const AI_TICK_FREKENCY :=200
const SPREAD_ASSIST_FORCE:=0.6

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
	if player.is_possession:
		total_steering_force += get_carrier_steering_force()
	else:
		total_steering_force += get_onduty_streering_force()
		if is_ball_carried_by_teammate():
			total_steering_force += get_assist_formation_steering_force()
			
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

func get_carrier_steering_force()-> Vector3:
	var target = player.goal_target.position
	var direction = player.position.direction_to(target)
	var weight = get_bicircular_weight(player.position, target, 3.5, 0 ,6.5, 1)
	player.look_at(player.goal_target.position)
	return weight * direction

func get_assist_formation_steering_force()-> Vector3:
	var spawn_difference = ball.carrier.spam_position - player.spam_position
	var assist_destination = ball.carrier.position - spawn_difference * SPREAD_ASSIST_FORCE
	var direction = player.position.direction_to(assist_destination)
	var weight = get_bicircular_weight(player.position, assist_destination, 5.0, 0.2, 9.0, 1)
	return weight * direction

func get_bicircular_weight(position: Vector3, target: Vector3, inner_circle_radius:float,inner_circle_weight:float,outer_circle_radius:float,outer_circle_weight:float)->float:
	var distans_to_target:=player.position.distance_to(target)
	if distans_to_target > outer_circle_radius:
		return outer_circle_weight
	elif distans_to_target < inner_circle_radius:
		return inner_circle_weight
	else:
		var distance_to_inner_radius := distans_to_target - inner_circle_radius
		var close_range_distance := outer_circle_radius - inner_circle_radius
		return lerpf(inner_circle_weight, outer_circle_weight, distance_to_inner_radius/close_range_distance)

func is_ball_carried_by_teammate():
	return ball.carrier != null and ball.carrier != player and player.is_team_possession()


	
	

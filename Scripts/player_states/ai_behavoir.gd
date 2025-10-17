class_name AIBehavoir
extends Node
const AI_TICK_FREKENCY :=200
var ball: Ball = null
var player : Player =null
var AI_time_stick:= Time.get_ticks_msec()

func _ready() -> void:
	var AI_time_stick:= Time.get_ticks_msec() + randi_range(0,AI_TICK_FREKENCY)
	player.teamate_distance.body_entered.connect(_teamate_distance.bind())
	
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
	if player.AI_speed >20:
		var moving = Vector3.ZERO
		moving  += player.position.direction_to(ball.position)
		if player.is_possession:
			moving  += player.position.direction_to(player.goal_target.position) 
			player.look_at(player.goal_target.position,Vector3.UP)
		
		#print(is_team_ball_carrier())
		#if is_team_ball_carrier():
			#player.last_valid_position = player.global_transform.origin
			#print(player.name)
		
		moving = moving.limit_length(1.0)
		player.velocity = moving * player.distance_check()  * delta
		
	else:
		player.velocity = Vector3.ZERO
		
		pass
	player.move_and_slide()
	pass

func is_team_ball_carrier():
	return player.is_teammate_possession()



	
	

func _teamate_distance(body: Player)->void:
	
	if player.is_teammate(body) and body != ball.carrier:
		if not body.is_possession:
			body.global_transform.origin = body.last_valid_position
			print(body.name)
	pass




# In the script attached to the player
#extends CharacterBody3D
#
#
#
#func _physics_process(delta):
	## Store the last valid position before moving
	#
	#move_and_slide() # Your player's movement code here
#
#func _on_boundary_area_body_entered(body):
	#if body == self: # Check if the body that entered is the player
		#

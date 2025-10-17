class_name  Player
extends CharacterBody3D


@export var rotation_speed = 8.0
@export var teammate1 = Node3D
@export var teammate2 = Node3D
@export var teammate3 = Node3D
@export var is_AI = false
@export var is_active = false
@export var  is_possession = false
@export var goal_target = Node3D
@export var ball = Node3D

@onready var shoot = $"../UI/kick"
@onready var pas = $"../UI/pass"
@onready var target = $CollisionShape3D/body/target

enum States {MOVING, TACKLING, PASSING, SHOOTING}

var squad = []
var speed = 1.2
var AI_speed = 150
var take_ball = false
var ball_old_parent
var ball_new_parent
var current_state: PlayerState = null
var state_factory := PlayerStateFactory.new()
var AI_behavoir := AIBehavoir.new()
var weigth_Sterring :=20.0
var spam_position := Vector3.ZERO
var weight_on_duty_sterring := 0.0
var DURATION_WEIGHT_CACHE :=200
var time_cash_refresh := Time.get_ticks_msec()


func _ready() -> void:
	
	ball = get_parent().get_child(1)
	switch_state(States.MOVING)
	look_at(ball.position)
	setup_AI_Behavoir()
	spam_position = position
	squad.append(teammate1)
	squad.append(teammate2)
	squad.append(teammate3)

func setup_AI_Behavoir()->void:
	AI_behavoir.setup(self,ball)
	AI_behavoir.name = "AI_Behavoir"
	add_child(AI_behavoir)
	
func switch_state(state: States)->void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self,ball, AI_behavoir)
	current_state.state_transition_requested.connect(switch_state.bind())
	current_state.name = "PlayerState: "+ str(States)
	call_deferred("add_child",current_state)



func _process(delta: float) -> void:
	if Time.get_ticks_msec() -time_cash_refresh > DURATION_WEIGHT_CACHE:
		time_cash_refresh
		set_on_duty_weigth()
	pass



func has_ball()->bool:
	return ball.carrier == self


func set_on_duty_weigth()->void:
	var AI_playerS = squad.filter(
		func(p:Player): return p.is_AI
	)
	AI_playerS.sort_custom(func(p1: Player, p2:Player):
		return p1.spam_position.distance_to(ball.position)<p2.spam_position.distance_to(ball.position)
		)
	
	for i in range(	AI_playerS.size()):
		AI_playerS[i].weight_on_duty_sterring = 1 - ease(float(i)/10.0,0.1)

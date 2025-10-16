class_name  Player
extends CharacterBody3D


@export var rotation_speed = 8.0
@export var teammate1 = Node3D
@export var teammate2 = Node3D
@export var is_AI = false
@export var is_active = false
@export var  is_possession = false
var squad = []
@export var ball = Node3D
var speed = 1.5




var take_ball = false
var ball_old_parent
var ball_new_parent

@onready var shoot = $"../UI/kick"
@onready var pas = $"../UI/pass"
@onready var target = $CollisionShape3D/body/target

enum States {MOVING, TACKLING, PASSING, SHOOTING}
var current_state: PlayerState = null
var state_factory := PlayerStateFactory.new()
var AI_behavoir := AIBehavoir.new()
var last_position := Vector3.ZERO
var weigth_Sterring :=0.0
@onready var goal = $"../goal1"

func _ready() -> void:
	ball = get_parent().get_child(1)
	switch_state(States.MOVING)
	look_at(ball.position)
	setup_AI_Behavoir()
	last_position = position
	squad.append(teammate1)
	squad.append(teammate2)
	
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







#func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	#print(body.name)
	#is_AI = false
	#if is_possession:
		#print("possession")
		#if body.is_in_group("ball"):
			#ball_move()
			#is_possession = true
	#
	#pass # Replace with function body.


# In the object's script (e.g., a projectile)



	


#func _on_kick_pressed() -> void:
	#shoot_ball()
	#
	#pass # Replace with function body.
#
#
#func _on_pass_pressed() -> void:
	#pass_ball()
	#pass # Replace with function body.
#
#
#func _on_spring_pressed() -> void:
	#pass # Replace with function body.
#func handle_ball_interaction(action):
	#if has_ball and action == "shoot":
		#shoot_ball()
	#elif has_ball and action == "pass":
		#pass_ball()


#
func distance_check():
	if position.distance_to(ball.position)<teammate1.position.distance_to(ball.position) and position.distance_to(ball.position)<teammate2.position.distance_to(ball.position):
		weigth_Sterring =100
		return true
func has_ball()->bool:
	return ball.carrier == self

func is_teammate():
	for team in squad:
		return team.is_possession
			
		
		

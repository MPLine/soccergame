class_name  Ball
extends RigidBody3D
var state_factory := BallStateFactory.new()
var current_state : BallState = null 
var carrier : Player = null
var has_carrier = false
enum States {CARRIED, FREEFORM, MOVEMENT}
@onready var ball =$CollisionShape3D/ball
@onready var player_detection : Area3D =$player_detecttion


func _ready() -> void:
	switch_state(States.FREEFORM)

func switch_state(state: States)->void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self,player_detection,carrier)
	current_state.state_transition_request.connect(switch_state.bind())
	current_state.name = "ballState: "+ str(States)
	call_deferred("add_child",current_state)
#func _process(delta: float) -> void:
	#rotate(Vector3.FORWARD,0.1)

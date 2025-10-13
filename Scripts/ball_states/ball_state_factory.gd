class_name BallStateFactory

var States : Dictionary

func _init() -> void:
	States ={
		Ball.States.CARRIED: BallStateCarried,
		Ball.States.FREEFORM: BallStateFreeform,
		Ball.States.SHOT: BallStateShoot
	}

func get_fresh_state(state: Ball.States)->BallState:
	assert(States.has(state), "invalid State")
	return States.get(state).new()

class_name PlayerStateFactory
var States : Dictionary

func _init() -> void:
	States ={
		Player.States.MOVING: PlayerStateMoving,
		Player.States.TACKLING: PlayerStateTackling,
		Player.States.PASSING: PlayerStatePass,
		Player.States.SHOOTING: PlayerStateShoot
	}

func get_fresh_state(state: Player.States)->PlayerState:
	assert(States.has(state), "invalid State")
	return States.get(state).new()

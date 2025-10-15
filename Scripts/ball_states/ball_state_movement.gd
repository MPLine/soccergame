class_name BallStateMovement
extends BallState



const duration_takle:= 200
var move_force = 3.0
var time_start_tackle := Time.get_ticks_msec()
var takle_speed = 5.0
func _enter_tree() -> void:
	time_start_tackle = Time.get_ticks_msec()
	var direction = -carrier.basis.z.normalized()
	ball.freeze = false
	ball.apply_impulse(direction * move_force)


	


func _process(delta: float) -> void:
	if Time.get_ticks_msec() - time_start_tackle> duration_takle:
		state_transition_request.emit(ball.States.CARRIED)
	elif (carrier.pas.is_pressed() or carrier.shoot.is_pressed()) and carrier.is_possession:
		state_transition_request.emit(ball.States.FREEFORM)

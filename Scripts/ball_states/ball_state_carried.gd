class_name BallStateCarried
extends BallState
var pass_force =1.5
func _enter_tree() -> void:
	assert(carrier!=null)
	ball.freeze = true
	carrier.is_possession = true
	
	ball.has_carrier = true
func _process(delta: float) -> void:

	#if carrier.velocity != Vector3.ZERO:
		##ball.ball.rotate(carrier.global_transform.basis.x,0.1)
		#state_transition_request.emit(ball.States.MOVEMENT)
	
	var direction = -ball.transform.basis.z.normalized()
	ball.apply_impulse(direction * pass_force)
	ball.global_position = carrier.target.global_position
	if (carrier.pas.is_pressed() or carrier.shoot.is_pressed()) and carrier.is_possession:
		pass
		state_transition_request.emit(ball.States.FREEFORM)

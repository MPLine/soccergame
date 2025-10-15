class_name BallStateFreeform
extends BallState

func _enter_tree() -> void:
	player_dection_area.body_entered.connect(on_player_enter.bind())
	ball.freeze = false
	ball.has_carrier = false
func on_player_enter(body: Player)->void:
	ball.carrier =body
	ball.carrier.is_AI = false
	ball.carrier.is_possession = true
	state_transition_request.emit(ball.States.CARRIED)
	

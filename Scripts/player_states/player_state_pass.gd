class_name PlayerStatePass
extends PlayerState


const duration_takle:= 100
var pass_force = 8.0
var time_start_tackle := Time.get_ticks_msec()
var takle_speed = 5.0
func _enter_tree() -> void:
	time_start_tackle = Time.get_ticks_msec()
	pass_ball()


	
func pass_ball():
	print("pass")
	var direction = -player.basis.z.normalized()
	player.ball.freeze = false
	player.ball.apply_impulse(direction * pass_force)
	#has_ball = false
	#player.is_active = false
	#


func _process(delta: float) -> void:

	if Time.get_ticks_msec() - time_start_tackle> duration_takle:
		player.is_possession = false
		if ball.carrier.is_player:
			ball.carrier.is_AI = true
		state_transition_requested.emit(player.States.MOVING)

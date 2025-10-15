class_name PlayerStateShoot
extends PlayerState

const duration_takle:= 100
var shoot_force = 16.0
var time_start_tackle := Time.get_ticks_msec()
var takle_speed = 5.0
func _enter_tree() -> void:
	time_start_tackle = Time.get_ticks_msec()
	shoot_ball()


func shoot_ball():
	var direction = -player.transform.basis.z.normalized()
	ball.apply_impulse(direction * shoot_force)
	player.is_active = false
	player.is_possession = false
	player.is_AI = true
	print("shoot")
	print(player.is_possession)
	

	

func _process(delta: float) -> void:

	if Time.get_ticks_msec() - time_start_tackle> duration_takle:
		state_transition_requested.emit(player.States.MOVING)

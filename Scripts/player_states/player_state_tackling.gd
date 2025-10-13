class_name PlayerStateTackling
extends PlayerState

const duration_takle:= 200

var time_start_tackle := Time.get_ticks_msec()
var takle_speed = 5.0
func _enter_tree() -> void:
	print("tackling")
	time_start_tackle = Time.get_ticks_msec()
	

func _process(delta: float) -> void:
	if Time.get_ticks_msec() - time_start_tackle> duration_takle:
		state_transition_requested.emit(Player.States.MOVING)
	else:
		var forward_direction = -player.global_transform.basis.z 
		var current_velocity = forward_direction * takle_speed
		
		player.velocity.x = current_velocity.x
		player.velocity.z = current_velocity.z
		player.move_and_slide() 

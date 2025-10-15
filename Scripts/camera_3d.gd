class_name  Camera
extends Camera3D

@onready var old_parent
@export var ball : Ball 
var lerp_speed = 2.5

func _physics_process(delta: float) -> void:
	if ball.has_carrier:
		var desired_position = ball.carrier.global_position 
		global_position.x = ball.carrier.global_position.x
		global_position.z = ball.carrier.global_position.z + 4
		global_position.y = 3
		
		print("has_carrier")
	else:
		global_position.x = ball.global_position.x
		global_position.z = ball.global_position.z + 4
		global_position.y = 3
		
	
		print("don't have carrier")


		

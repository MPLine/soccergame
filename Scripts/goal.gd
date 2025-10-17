class_name  GoalBehavior
extends Node3D


@export var shoot_area =Node3D
func _ready()-> void:
	shoot_area.body_entered.connect(shoot.bind())
	

func shoot(body: Player)->void:
	if body.is_possession and body.is_AI:
		body.speed = 0

	pass

class_name  GoalBehavior
extends Node3D


@onready var shoot_area =$shoot_area
func _ready()-> void:
	shoot_area.body_entered.connect(shoot.bind())
	

func shoot(body: Player)->void:
	if body.is_possession and body.is_AI:
		print("enter shoot area body")
		body.AI_speed *= -1
	pass

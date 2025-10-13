class_name BallState
extends Node

signal state_transition_request(new_state: Ball.States)

var ball : Ball =null
var player_dection_area : Area3D = null
var carrier : Player = null
func setup(context_ball: Ball, context_detection : Area3D, context_carrier : Player)->void:
	ball = context_ball
	player_dection_area = context_detection
	carrier = context_carrier

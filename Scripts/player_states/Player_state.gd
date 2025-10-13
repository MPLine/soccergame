class_name PlayerState
extends Node

signal state_transition_requested(new_state: Player.States)

var player : Player = null
var ball : Ball = null
func setup(context_player:Player, context_ball:Ball)-> void:
	player = context_player
	ball = context_ball

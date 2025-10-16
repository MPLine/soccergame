class_name PlayerState
extends Node

signal state_transition_requested(new_state: Player.States)

var player : Player = null
var ball : Ball = null
var AI_Behavoir = AIBehavoir
func setup(context_player:Player, context_ball:Ball, context_AI : AIBehavoir)-> void:
	player = context_player
	ball = context_ball
	AI_Behavoir = context_AI

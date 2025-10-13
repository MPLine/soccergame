class_name PlayerState
extends Node

signal state_transition_requested(new_state: Player.States)

var player : Player = null

func setup(context_player:Player)-> void:
	player = context_player

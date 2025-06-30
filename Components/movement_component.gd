class_name MovementComponent extends Node2D

var moving_to: Vector2i = Vector2i(-1, -1)
var is_going_to_move: bool = false

func reset_movement() -> void:
	moving_to = Vector2i(-1, -1)
	is_going_to_move = false

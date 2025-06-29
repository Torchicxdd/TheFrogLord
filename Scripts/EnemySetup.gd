class_name EnemySetup extends Node

@export var enemy: Enemy
@export var pos: Vector2i

func _init(new_enemy: Enemy, new_pos: Vector2i) -> void:
	self.enemy = new_enemy
	self.pos = new_pos

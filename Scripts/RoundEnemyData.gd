class_name RoundEnemyData extends Node

@export var enemies: Array[EnemySetup]

func _init(new_characters: Array[EnemySetup]) -> void:
	self.enemies = new_characters

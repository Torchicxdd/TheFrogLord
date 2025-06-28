class_name HealthComponent extends Node2D

@export var health = 500
@export var armour = 0

func damage(amount: int) -> void:
	health -= amount * (100 / (100 + armour))

func heal(amount: int) -> void:
	health += amount

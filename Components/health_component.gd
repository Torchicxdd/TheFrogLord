class_name HealthComponent extends Node2D

@export var health = 500
@export var armour = 0
@onready var health_bar = $HealthBar/TextureProgressBar

func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health

func damage(amount: int) -> void:
	health -= amount * (100 / (100 + armour))
	health_bar.value = health

func heal(amount: int) -> void:
	health += amount
	health_bar.value = health

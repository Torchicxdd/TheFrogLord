class_name LevelHud extends Node2D

@onready var sprite = $Sprite2D

func _ready() -> void:
	SignalBus.connect("start_level", Callable(self, "start_level"))

func start_level(level: String) -> void:
	match level:
		"1":
			sprite.texture = load("res://Scenes/LevelHud/level1_hud.png")
		"2":
			sprite.texture = load("res://Scenes/LevelHud/level2_hud.png")
		"3":
			sprite.texture = load("res://Scenes/LevelHud/level3_hud.png")
		"4":
			sprite.texture = load("res://Scenes/LevelHud/level4_hud.png")
		"5":
			sprite.texture = load("res://Scenes/LevelHud/level5_hud.png")
		_:
			# Load a level texture even if it's wrong
			sprite.texture = load("res://Scenes/LevelHud/level1_hud.png")

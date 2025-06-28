class_name LevelHud extends Node2D

var sprite_texture = $Sprite2D.texture

func _ready() -> void:
	SignalBus.connect("start_level", Callable(self, "start_level"))

func start_level(level: String) -> void:
	match level:
		"1":
			sprite_texture = load("res://Scenes/LevelHud/level1_hud.png")
		"2":
			sprite_texture = load("res://Scenes/LevelHud/level2_hud.png")
		"3":
			sprite_texture = load("res://Scenes/LevelHud/level3_hud.png")
		"4":
			sprite_texture = load("res://Scenes/LevelHud/level4_hud.png")
		"5":
			sprite_texture = load("res://Scenes/LevelHud/level5_hud.png")
		_:
			# Load a level texture even if it's wrong
			sprite_texture = load("res://Scenes/LevelHud/level1_hud.png")

extends Node2D

var health: int = 3

func _ready() -> void:
	SignalBus.connect("lose_heart", Callable(self, "lose_heart"))

func lose_heart(amount: int = 1) -> void:
	health -= amount
	match health:
		2:
			$Heart3.texture = load("res://Scenes/Resources/empty_heart.png")
		1:
			$Heart2.texture = load("res://Scenes/Resources/empty_heart.png")
		0:
			$Heart.texture = load("res://Scenes/Resources/empty_heart.png")

func gain_heart(amount: int = 1) -> void:
	health += amount
	match health:
		3:
			$Heart3.texture = load("res://Scenes/Resources/empty_heart.png")
		2:
			$Heart2.texture = load("res://Scenes/Resources/empty_heart.png")
		1:
			$Heart.texture = load("res://Scenes/Resources/empty_heart.png")

func _process(delta: float) -> void:
	if health <= 0:
		SignalBus.emit_signal("player_death")

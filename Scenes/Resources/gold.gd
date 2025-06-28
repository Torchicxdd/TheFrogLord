extends Node2D

@onready var gold_text = $GoldLabel.text

var gold: int = 0

func _ready() -> void:
	SignalBus.connect("gain_gold", Callable(self, "add_gold"))
	SignalBus.connect("lose_gold", Callable(self, "remove_gold"))

func add_gold(amount: int) -> void:
	gold += amount
	gold_text = "%d G" % gold

func lose_gold(amount: int) -> void:
	gold -= amount
	if gold < 0:
		gold = 0
	gold_text = "%d G" % gold

class_name Board extends Node2D

@export var reroll_cost: int = 5

func _ready():
	SignalBus.connect("check_if_shop_can_be_rerolled",  Callable(self, "check_if_shop_can_be_rerolled"))
	SignalBus.connect("check_if_card_can_be_bought", Callable(self, "check_if_card_can_be_bought"))

func check_if_shop_can_be_rerolled():
	var current_gold = $Resources/Gold.gold
	if current_gold >= reroll_cost:
		SignalBus.emit_signal("reroll_shop")
		SignalBus.emit_signal("lose_gold", reroll_cost)
	else:
		print("Not enough gold to reroll the shop. Current gold: ", current_gold)

func check_if_card_can_be_bought(card: CardComponent):
	var current_gold = $Resources/Gold.gold
	if current_gold >= card.cost:
		SignalBus.emit_signal("buy_card", card)
		SignalBus.emit_signal("lose_gold", card.cost)
	else:
		print("Not enough gold to buy the card: ", card.card_name, ". Current gold: ", current_gold)

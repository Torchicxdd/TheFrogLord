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
	var bench = $Bench.get_children()
	var open_bench_slot: Cell = null

	for cell: Cell in bench:
		if not cell.is_occupied:
			open_bench_slot = cell
			break
	
	if current_gold >= card.cost and open_bench_slot:
		create_character(card, open_bench_slot)

		SignalBus.emit_signal("buy_card", card)
		SignalBus.emit_signal("lose_gold", card.cost)
	else:
		print("Cannot buy card OpenBenchSlot:", open_bench_slot, "Current_Gold:", current_gold)

func create_character(card: CardComponent, cell: Cell):
	print("res://Characters/%s/%s.tscn" % [card.card_name, card.card_name])
	var character = load("res://Characters/%s/%s.tscn" % [card.card_name, card.card_name]).instantiate()
	cell.add_child(character)
	cell.place_character(character, cell.INCOMING_LOCATION.SHOP)
	print("Character created from card: ", card.card_name, " at cell: ", cell)

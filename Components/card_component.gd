class_name CardComponent extends Button

enum CardType {
	CHARACTER,
	MODIFIER,
}

@export var card_name: String = "DefaultCardName"
@export var cost: int = 1
@export var card_type: CardType = CardType.CHARACTER

func _ready():
	# Connect the button's pressed signal to the _on_pressed function
	connect("pressed", Callable(self, "_on_pressed"))
	connect("buy_card", Callable(self, "buy_card"))

# When the button is pressed, emmit signal to check if the card can be bought
func _on_pressed():
	SignalBus.emit_signal("check_if_card_can_be_bought", card_name, cost, card_type)
	print("Checking if card can be bought: %s for %d" % [card_name, cost])

	# For testing, simulate a successful purchase
	queue_free()

func buy_card():
	print("Card bought: %s for %d" % [card_name, cost])

	# After the card has been bought, delete the button
	queue_free()

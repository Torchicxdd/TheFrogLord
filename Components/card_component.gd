class_name CardComponent extends Button

enum CardType {
	CHARACTER,
	MODIFIER,
}

@export var card_name: String = "Bohao"
@export var cost: int = 1
@export var card_type: CardType = CardType.CHARACTER

func _ready():
	# Connect the button's pressed signal to the _on_pressed function
	connect("pressed", Callable(self, "_on_pressed"))
	SignalBus.connect("buy_card", Callable(self, "buy_card"))

# When the button is pressed, emmit signal to check if the card can be bought
func _on_pressed():
	SignalBus.emit_signal("check_if_card_can_be_bought", self)

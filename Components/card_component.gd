class_name CardComponent extends Button

@export var card_name: String = "DefaultCardName"
@export var cost: int = 1

func _ready():
	# Connect the button's pressed signal to the _on_pressed function
	connect("pressed", Callable(self, "_on_pressed"))

# When the button is pressed, emmit signal to check if the card can be bought
func _on_pressed():
	SignalBus.emit_signal("check_if_card_can_be_bought", card_name, cost)
	print("Checking if card can be bought: %s for %d" % [card_name, cost])

func buy_card():
	SignalBus.emit_signal("card_bought", card_name, cost)
	print("Card bought: %s for %d" % [card_name, cost])

	# After the card has been bought, delete the button
	queue_free()

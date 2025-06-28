class_name CardComponent extends Button

@export var card_name: String = "DefaultCardName"
@export var cost: int = 1

func _ready():
	# Connect the button's pressed signal to the _on_pressed function
	connect("pressed", Callable(self, "_on_pressed"))

# When the button is pressed, it will trigger the buy_card function
func _on_pressed():
	buy_card()
	# After the card has been bought, delete the button
	queue_free()

func buy_card():
	print("Card bought: %s for %d" % [card_name, cost])
	SignalBus.emit_signal("card_bought", card_name, cost)

extends Button

func _ready():
	# Connect the button's pressed signal to the _on_pressed function
	connect("pressed", Callable(self, "_on_pressed"))

# When the button is pressed, emit signal to check if the shop can be rerolled
func _on_pressed():
	SignalBus.emit_signal("check_if_shop_can_be_rerolled")

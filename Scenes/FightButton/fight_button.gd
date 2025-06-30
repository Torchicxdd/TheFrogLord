extends Button

func _ready():
	connect("pressed", Callable(self, "_on_pressed"))

# When the button is pressed, emit signal to check if the shop can be rerolled
func _on_pressed():
	SignalBus.emit_signal("start_round")

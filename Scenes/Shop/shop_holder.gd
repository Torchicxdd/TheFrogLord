extends Node2D

func _ready():
	# Connect the reroll_shop signal to the reroll_shop function
	SignalBus.connect("reroll_shop", Callable(self, "reroll_shop"))
	SignalBus.connect("buy_card", Callable(self, "buy_card"))

func reroll_shop():
	# Arrays containg the current characters and modifiers in the shop 
	var current_characters : Array = $CharacterContainer.get_children()
	var current_modifiers : Array = $ModifierContainer.get_children()

	# Clear the current characters and modifiers
	for character in current_characters:
		character.queue_free()
	for modifier in current_modifiers:
		modifier.queue_free()
	
	# Refill the shop with 3 new characters and modifiers
	# For now just add copies of Bohao with cost of 1
	for i in range(3):
		var character = load("res://Components/CardComponent.tscn").instantiate()
		character.cost = 1
		character.card_name = "Bohao"
		character.card_type = CardComponent.CardType.CHARACTER
		$CharacterContainer.add_child(character)
	
	for i in range(3):
		var modifier = load("res://Components/CardComponent.tscn").instantiate()
		modifier.cost = 1
		modifier.card_name = "Bohao"
		modifier.card_type = CardComponent.CardType.MODIFIER
		$ModifierContainer.add_child(modifier)
	
func buy_card(card: CardComponent):
	# After the card has been bought, delete the button
	card.queue_free()

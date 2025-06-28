extends Node

signal start_level(level: String)
signal lose_heart()
signal player_death()
signal gain_gold(amount: int)
signal lose_gold(amount: int)
signal is_placing_character(is_placing: bool, character: Character)
signal place_character(cell: Node2D, character: Character)

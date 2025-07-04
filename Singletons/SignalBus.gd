extends Node

signal start_level(level: String)
signal lose_heart()
signal player_death()
signal gain_gold(amount: int)
signal lose_gold(amount: int)
signal check_if_card_can_be_bought(card: CardComponent)
signal buy_card(card: CardComponent)
signal check_if_shop_can_be_rerolled()
signal reroll_shop()
signal is_placing_character(incoming_character: Character, from: Cell)
signal is_not_placing_character()
signal dropped_character()
signal place_character(cell: Cell)
signal remove_character(cell: Cell)
signal update_traits(character: Character, cell: Cell, from: Cell)
signal start_round()

extends Node

signal start_level(level: String)
signal lose_heart()
signal player_death()
signal gain_gold(amount: int)
signal lose_gold(amount: int)
signal check_if_card_can_be_bought(card_name: String, cost: int, card_type: int)
signal buy_card(card_name: String, cost: int, card_type: int)
signal check_if_shop_can_be_rerolled()
signal reroll_shop()

class_name EnemyBoardCell extends Cell

func place_enemy(character: Enemy) -> void:
	place_character(character, Cell.INCOMING_LOCATION.SHOP)

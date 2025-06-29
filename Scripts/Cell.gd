class_name Cell extends Node2D

enum INCOMING_LOCATION {SHOP, BOARD}

var is_occupied: bool = false
var character: Character = null

func place_character(incoming_character: Character, place_type: INCOMING_LOCATION, from: Cell = null) -> void:
	match place_type:
		INCOMING_LOCATION.SHOP:
			is_occupied = true
			character = incoming_character
			character.position = position
		INCOMING_LOCATION.BOARD:
			if is_occupied:
				# Swap characters
				from.character = character
				from.character.position = from.position
				character = incoming_character
				character.position = position
			else:
				# Take character
				is_occupied = true
				character = incoming_character
				from.character = null
				from.is_occupied = false
				character.position = position

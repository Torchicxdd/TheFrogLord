class_name Cell extends Node2D

enum INCOMING_LOCATION {SHOP, BOARD}
enum CELL_TYPE {BENCH, BOARD, ENEMY}

var is_occupied: bool = false
var character: Character = null
const x_offset = 0
const y_offset = -30

@export var cell_type: CELL_TYPE = CELL_TYPE.BOARD

func clear_character() -> void:
	is_occupied = false
	character = null

func place_character(incoming_character: Character, place_type: INCOMING_LOCATION, from: Cell = null) -> void:
	match place_type:
		INCOMING_LOCATION.SHOP:
			is_occupied = true
			character = incoming_character
			character.position = Vector2.ZERO
			character.position += Vector2(x_offset, y_offset)
		INCOMING_LOCATION.BOARD:
			if is_occupied:
				# Swap characters
				var temp_character = character
				character = incoming_character
				from.character = temp_character
				character.reparent(self)
				from.character.reparent(from)
				from.character.position = Vector2.ZERO
				from.character.position += Vector2(x_offset, y_offset)
				character.position = Vector2.ZERO
				character.position += Vector2(x_offset, y_offset)
			else:
				# Take character
				SignalBus.emit_signal("place_character", self)
				SignalBus.emit_signal("remove_character", from)
				is_occupied = true
				character = incoming_character
				from.clear_character()
				incoming_character.reparent(self)
				character.position = Vector2.ZERO
				character.position += Vector2(x_offset, y_offset)
		
			# Update traits in TraitHud
			SignalBus.emit_signal("update_traits", character, self, from)

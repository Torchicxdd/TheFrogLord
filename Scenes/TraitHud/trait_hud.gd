class_name TraitHud extends Node2D

enum CELL_TYPE {BENCH, BOARD, ENEMY}

func _ready() -> void:
	SignalBus.connect("update_traits", Callable(self, "update_traits"))

func update_traits(character: Character, cell: Cell, from: Cell) -> void:
	print("Updating traits for character: ", character.name, " in cell: ", cell.name)
	for t in character.traits:
		print("Updating trait: ", t.trait_name)
		var trait_box: TraitBox = get_child(t.trait_name)
		if trait_box:
			if cell.cell_type == CELL_TYPE.BOARD and from.cell_type == CELL_TYPE.BENCH:
				trait_box.update_trait_level(1)
			elif cell.cell_type == CELL_TYPE.BENCH and from.cell_type == CELL_TYPE.BOARD:
				trait_box.update_trait_level(-1)

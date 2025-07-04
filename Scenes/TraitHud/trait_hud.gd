class_name TraitHud extends Node2D

func _ready() -> void:
	SignalBus.connect("update_traits", Callable(self, "update_traits"))

func update_traits(character: Character, cell: Cell, from: Cell) -> void:
	print("TraitHud update_traits: character:", character.name, ", cell: ", cell.name, ", from: ", from.name)
	for t in character.traits:
		var trait_box: TraitBox = get_child(t.trait_name)
		if trait_box:
			if cell is BoardCell and from is BenchCell:
				trait_box.update_trait_level(1)
			elif cell is BenchCell and from is BoardCell:
				trait_box.update_trait_level(-1)

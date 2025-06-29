class_name LevelComponent extends Node2D

@export var levelEnemyData: LevelEnemyData
@export var world: Node2D
var round_index = 0
var board: PlayBoard

func _ready() -> void:
	board = get_parent().find_child("PlayBoard")
	load_next_round()
	load_next_round()
	load_next_round()

# Loops through a list of predefined enemies from LevelEnemyData object
func load_next_round():
	for round_num in range(levelEnemyData.enemies_per_level.size()):
		if round_num == round_index:
			for enemy in levelEnemyData.enemies_per_level[round_num].enemies:
				var cell = board.place_enemy(enemy.pos)
				if cell:
					cell.add_child(enemy.enemy)
					cell.place_character(enemy.enemy, Cell.INCOMING_LOCATION.SHOP)
	
	round_index += 1

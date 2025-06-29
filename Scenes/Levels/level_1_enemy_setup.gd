extends LevelEnemyData

var round1_enemy_setup: Array[EnemySetup] = [
	EnemySetup.new(PreloadedEnemies.dosha.instantiate(), Vector2i(4, 2))
]
var round2_enemy_setup: Array[EnemySetup] = [
	EnemySetup.new(PreloadedEnemies.dosha.instantiate(), Vector2i(4, 1)),
	EnemySetup.new(PreloadedEnemies.dosha.instantiate(), Vector2i(4, 0))
]
var round3_enemy_setup: Array[EnemySetup] = [
	EnemySetup.new(PreloadedEnemies.dosha.instantiate(), Vector2i(4, 3))
]
var round1_enemy_data: RoundEnemyData = RoundEnemyData.new(round1_enemy_setup)
var round2_enemy_data: RoundEnemyData = RoundEnemyData.new(round2_enemy_setup)
var round3_enemy_data: RoundEnemyData = RoundEnemyData.new(round3_enemy_setup)

func _ready() -> void:
	enemies_per_level = [round1_enemy_data, round2_enemy_data, round3_enemy_data]

class_name PlayBoard extends Node2D

const BOARD_WIDTH = 6
const BOARD_HEIGHT = 4
var astar_grid = AStarGrid2D.new()
@onready var userCellNodes = $UserCells.get_children()
@onready var enemyCellNodes = $Enemycells.get_children()

var cells: Array[Cell] = []
var playboard_cells: Array[PlayBoardCell] = []
const BOARD_SEPERATION = 12

class PlayBoardCell:
	var pos: Vector2i
	var cell: Cell
	var index: int
	func _init(new_cell: Cell, new_index: int) -> void:
		self.pos = find_pos(new_index)
		self.cell = new_cell
		self.index = new_index
	
	func find_pos(index) -> Vector2i:
		var count = 0
		for x in range(0, BOARD_WIDTH):
			for y in range(0, BOARD_HEIGHT):
				if count == index:
					return Vector2i(x, y)
				count += 1
		return Vector2i(-1, -1)

func _ready() -> void:
	SignalBus.connect("place_character", Callable(self, "place_character"))
	SignalBus.connect("remove_character", Callable(self, "remove_character"))
	SignalBus.connect("start_round", Callable(self, "play"))
	for cell in userCellNodes:
		cells.append(cell)
	for cell in enemyCellNodes:
		cells.append(cell)
	setup_grid()
	setup_cells()

func setup_cells() -> void:
	var counter = 0
	
	for cell in range(userCellNodes.size()):
		var new_playboard_cell = PlayBoardCell.new(userCellNodes[cell], cell)
		playboard_cells.append(new_playboard_cell)
		
		counter += 1
	for cell in range(enemyCellNodes.size()):
		playboard_cells.append(PlayBoardCell.new(enemyCellNodes[cell], counter))
		counter += 1

func setup_grid() -> void:
	astar_grid.region = Rect2i(0, 0, BOARD_WIDTH, BOARD_HEIGHT)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER # SETTING THIS TO DIAGONAL MODE MAX PUTS IT TO NEVER
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.update()

func play() -> void:
	var all_characters: Array[PlayBoardCell] = find_all_occupied_cells()
	var moving_positions = assign_character_movement(all_characters)
	make_unique_movement_positions(all_characters, moving_positions)
	for character in all_characters:
		move_character(character)
	
func reset_board(characters: Array[PlayBoardCell]) -> void:
	for character in characters:
		character.cell.character.movement_component.reset_movement()
	
func move_character(character: PlayBoardCell) -> void:
	var cell_to_move_to = find_playboard_cell_vector(character.cell.character.movement_component.moving_to)
	if cell_to_move_to:
		# Move character for astar
		place_character(cell_to_move_to.cell)
		remove_character(character.cell)
		
		# Move character to ui
		cell_to_move_to.cell.place_character(character.cell.character, Cell.INCOMING_LOCATION.BOARD, character.cell)
	
# Searches to see if all characters need to move
func assign_character_movement(all_characters: Array[PlayBoardCell]) -> Array[Vector2i]:
	var positions: Array[Vector2i] = []
	for character in all_characters:
		var closest_target = find_closest_target(character)
		var in_range = character.pos.distance_to(closest_target.pos) <= character.cell.character.dmg_component.range
		if not in_range:
			var moving_to = find_first_point_to_target(character, closest_target)
			character.cell.character.movement_component.moving_to = moving_to
			character.cell.character.movement_component.is_going_to_move = true
		positions.append(character.cell.character.movement_component.moving_to)
	return positions

func make_unique_movement_positions(all_characters: Array[PlayBoardCell], moving_positions: Array[Vector2i]) -> void:
	var seen_positions = {}
	
	var character_counter = 0
	var movement_counter = 0
	for character in all_characters:
		var pos = character.cell.character.movement_component.moving_to
		
		if seen_positions.has(pos):
			character.cell.character.movement_component.reset_movement()
		else:
			seen_positions[pos] = true

func find_playboard_cell(cell: Cell) -> PlayBoardCell:
	for playboard_cell in playboard_cells:
		if playboard_cell.cell == cell:
			return playboard_cell
	return null

func find_playboard_cell_vector(pos: Vector2i) -> PlayBoardCell:
	for cell: PlayBoardCell in playboard_cells:
		if cell.pos == pos:
			return cell
	return null

func place_character(cell: Cell) -> void:
	var cell_index = -1
	for board_cell in range(playboard_cells.size()):
		if playboard_cells[board_cell].cell == cell and not playboard_cells[board_cell].cell.is_occupied:
			cell_index = board_cell
			break
	
	# Cell exists
	if not cell_index == -1:
		astar_grid.set_point_solid(playboard_cells[cell_index].pos, true)
		print("Placed character on tile:", playboard_cells[cell_index].pos)

func place_enemy(pos: Vector2i) -> Cell:
	for cell in playboard_cells:
		if cell.pos == pos:
			# Looping twice here, could rework if keep working on it
			place_character(cell.cell)
			return cell.cell
	return null

func remove_character(cell: Cell) -> void:
	var cell_index = -1
	for board_cell in range(playboard_cells.size()):
		if playboard_cells[board_cell].cell == cell and playboard_cells[board_cell].cell.is_occupied:
			cell_index = board_cell
			break
	
	# Cell exists and is occupied
	if not cell_index == -1:
		astar_grid.set_point_solid(playboard_cells[cell_index].pos, false)
		print("Removed character on tile:", playboard_cells[cell_index].pos)

func find_first_point_to_target(from: PlayBoardCell, target: PlayBoardCell) -> Vector2i:
	var path = astar_grid.get_point_path(from.pos, target.pos, true)
	return path[1]

func find_all_occupied_cells() -> Array[PlayBoardCell]:
	var occupied_cells: Array[PlayBoardCell] = []
	
	for cell in playboard_cells:
		if cell.cell.is_occupied:
			occupied_cells.append(cell)
	return occupied_cells

# Performs a breath-first search to find closest enemy target
func find_closest_target(requesting_cell: PlayBoardCell) -> PlayBoardCell:
	var requesting_cell_is_enemy = requesting_cell.cell.character is Enemy
	var visited = {}
	var queue: Array[PlayBoardCell] = [requesting_cell]
	
	while not queue.is_empty():
		var current: PlayBoardCell = queue.pop_front()
		
		if current in visited:
			continue
		visited[current] = true
		
		if current.cell.is_occupied:
			var current_is_enemy = current.cell.character is Enemy
			if requesting_cell_is_enemy != current_is_enemy:
				if (current.pos.x != requesting_cell.pos.x or current.pos.y != requesting_cell.pos.y):
					return current
		
		for dir in [Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT, Vector2i.UP]:
			var search_x = current.pos.x + dir.x
			var search_y = current.pos.y + dir.y
			if search_x >= 0 and search_x < BOARD_WIDTH and search_y >= 0 and search_y < BOARD_HEIGHT:
				queue.append(find_playboard_cell_vector(Vector2i(search_x, search_y)))
	
	return null

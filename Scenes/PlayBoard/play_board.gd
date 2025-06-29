class_name PlayBoard extends Node2D

const BOARD_WIDTH = 6
const BOARD_HEIGHT = 4
var astar_grid = AStarGrid2D.new()
@onready var userCellNodes = $UserCells.get_children()
@onready var enemyCellNodes = $Enemycells.get_children()
var cells: Array[Cell] = []
var playboard_cells: Array[PlayBoardCell] = []

class PlayBoardCell:
	var pos: Vector2i
	var cell: Cell
	func _init(new_cell: Cell, index: int) -> void:
		self.pos = find_pos(index)
		self.cell = new_cell
	
	func find_pos(index) -> Vector2i:
		var count = 0
		for x in BOARD_WIDTH:
			for y in BOARD_HEIGHT:
				if count == index:
					return Vector2i(x, y)
				count += 1
		return Vector2i(-1, -1)

func _ready() -> void:
	SignalBus.connect("place_character", Callable(self, "place_character"))
	for cell in userCellNodes:
		cells.append(cell)
	for cell in enemyCellNodes:
		cells.append(cell)
	setup_cells()
	setup_grid()

func setup_cells() -> void:
	for cell in range(cells.size()):
		playboard_cells.append(PlayBoardCell.new(cells[cell], cell))

func setup_grid() -> void:
	astar_grid.region = Rect2i(0, 0, BOARD_WIDTH, BOARD_HEIGHT)
	astar_grid.update()

func place_character(cell: Cell) -> void:
	var cell_index = -1
	for board_cell in range(playboard_cells.size()):
		if playboard_cells[board_cell].cell == cell:
			cell_index = board_cell
			break
	
	# Cell exists
	if not cell_index == -1:
		astar_grid.set_point_solid(playboard_cells[cell_index].pos)

func place_enemy(pos: Vector2i) -> Cell:
	for cell in playboard_cells:
		if cell.pos == pos:
			# Looping twice here, could rework if keep working on it
			place_character(cell.cell)
			return cell.cell
	return null

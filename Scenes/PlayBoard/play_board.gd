class_name PlayBoard extends Node2D

const BOARD_WIDTH = 3
const BOARD_HEIGHT = 4
var astar_grid = AStarGrid2D.new()
@onready var userCellNodes = $UserCells.get_children()
var cells: Array[PlayBoardCell] = []

class PlayBoardCell:
	var pos: Vector2i
	var cell: Cell
	func _init(cell: Cell, index: int) -> void:
		self.pos = find_pos(index)
		self.cell = cell
	
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
	setup_cells()
	setup_grid()

func setup_cells() -> void:
	for cell in range(userCellNodes.size()):
		cells.append(PlayBoardCell.new(userCellNodes[cell], cell))

func setup_grid() -> void:
	astar_grid.region = Rect2i(0, 0, BOARD_WIDTH, BOARD_HEIGHT)
	astar_grid.update()

func place_character(cell: Cell) -> void:
	var cell_index = cells.find(cell)
	# Cell exists
	if not cell_index == -1:
		astar_grid.set_point_solid(cells[cell_index].pos)

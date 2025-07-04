class_name BoardCell extends Cell

var pos: Vector2i

func _init(index: int) -> void:
	var count = 0
	self.pos = Vector2i(-1, -1)
	for x in range(0, Globals.BOARD_WIDTH):
		for y in range(0, Globals.BOARD_HEIGHT):
			if count == index:
				self.pos = Vector2i(x, y)
			count += 1
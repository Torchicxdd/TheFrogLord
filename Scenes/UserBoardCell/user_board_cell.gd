class_name UserBoardCell extends Cell

var is_placing_character: bool = false
var is_hovering: bool = false
var incoming_character: Character = null
var from: Cell = null
var mouse_offset = Vector2.ZERO
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	SignalBus.connect("is_placing_character", Callable(self, "_is_placing_character"))
	SignalBus.connect("is_not_placing_character", Callable(self, "_is_not_placing_character"))
	SignalBus.connect("dropped_character", Callable(self, "_dropped_character"))

func _process(delta: float) -> void:
	# Make sure this only gets called once by the cell placing
	if from == self:
		if is_placing_character:
			character.position = get_global_mouse_position() + mouse_offset

func _is_placing_character(character: Character, from_cell: Cell) -> void:
	is_placing_character = true
	incoming_character = character
	from = from_cell
	
func _is_not_placing_character() -> void:
	incoming_character = null
	from = null

func _dropped_character() -> void:
	is_placing_character = false

func _on_area_2d_mouse_entered() -> void:
	is_hovering = true
	if is_placing_character:
		sprite.texture = load("res://Scenes/UserBoardCell/user_board_cell_hover.png")

func _on_area_2d_mouse_exited() -> void:
	is_hovering = false
	sprite.texture = load("res://Scenes/UserBoardCell/user_board_cell.png")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click") and is_hovering and is_occupied:
		SignalBus.emit_signal("is_placing_character", character, self)
		mouse_offset = Vector2.ZERO - get_global_mouse_position()
		
	if event.is_action_released("left_click") and is_hovering and is_placing_character:
		SignalBus.emit_signal("dropped_character")
		place_character(incoming_character, Cell.INCOMING_LOCATION.BOARD, from)
		SignalBus.emit_signal("is_not_placing_character")
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("left_click") and is_placing_character and not is_hovering:
		if from == self:
			incoming_character.position = Vector2.ZERO

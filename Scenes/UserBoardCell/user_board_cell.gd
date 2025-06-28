class_name UserBoardCell extends Cell

var is_placing_character: bool = false
var is_hovering: bool = false
var character_held: Character = null
var character_from: Cell = null
@onready var sprite = $Sprite2D

func _ready() -> void:
	SignalBus.connect("is_placing_character", Callable(self, "set_is_placing_character"))

func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click"):
		if not character == null:
			SignalBus.emit_signal("is_placing_character", true, character, self)
	

func set_is_placing_character(is_placing: bool, character: Character, cell: Cell) -> void:
	is_placing_character = is_placing
	if not is_placing_character:
		character_held = null
		character_from = null
		sprite.texture = load("res://Scenes/UserBoardCell/user_board_cell.png")
	else:
		character_held = character
		character_from = cell

func _on_area_2d_mouse_entered() -> void:
	if is_placing_character:
		is_hovering = true
		sprite.texture = load("res://Scenes/UserBoardCell/user_board_cell_hover.png")

func _on_area_2d_mouse_exited() -> void:
	if is_placing_character:
		is_hovering = false
		sprite.texture = load("res://Scenes/UserBoardCell/user_board_cell.png")

func _input(event: InputEvent) -> void:
	if event.is_action_released("left_click") and is_hovering:
		# Place character on cell
		place_character(character_held, INCOMING_LOCATION.BOARD, character_from)

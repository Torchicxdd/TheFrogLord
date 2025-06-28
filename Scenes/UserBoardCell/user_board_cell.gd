extends Node2D

var is_placing_character: bool = false
var is_hovering: bool = false
var character: Character = null
@onready var sprite = $Sprite2D

func _ready() -> void:
	SignalBus.connect("is_placing_character", Callable(self, "set_is_placing_character"))

func set_is_placing_character(is_placing: bool, character: Character) -> void:
	is_placing_character = is_placing
	if not is_placing_character:
		character = null
		sprite.texture = load("res://Scenes/UserBoardCell/user_board_cell.png")
	else:
		character = character

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
		SignalBus.emit_signal("place_character", self, character)

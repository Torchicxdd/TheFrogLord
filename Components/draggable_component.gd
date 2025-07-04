class_name DraggableComponent extends Node2D

@export var node: Node
@export var body: Area2D # The draggable hitbox
var is_hovering: bool = false
var is_dragging_character: bool = false
var mouse_offset = Vector2.ZERO
@onready var last_position = node.position

func _process(_delta: float) -> void:
	if is_dragging_character:
		node.position = get_global_mouse_position() + mouse_offset + last_position

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click") and is_hovering:
		is_dragging_character = true
		mouse_offset = Vector2.ZERO - get_global_mouse_position()
		node.position = last_position
		
	if event.is_action_released("left_click") and is_hovering:
		is_dragging_character = false
		last_position = node.position
		SignalBus.emit_signal("drop_attachable", node)

func _on_area_2d_mouse_entered() -> void:
	is_hovering = true

func _on_area_2d_mouse_exited() -> void:
	is_hovering = false

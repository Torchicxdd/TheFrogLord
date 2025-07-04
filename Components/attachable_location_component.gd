class_name AttachableLocationComponent extends Node2D

@export var node: Node
@export var body: Area2D
var is_hovering: bool = false

func _ready() -> void:
	SignalBus.connect("drop_attachable", Callable(self, "_on_drop_attachable"))

func _on_drop_attachable(attachable: Node) -> void:
	if is_hovering:
		attachable.reparent(node)

func _on_area_2d_mouse_entered() -> void:
	is_hovering = true

func _on_area_2d_mouse_exited() -> void:
	is_hovering = false

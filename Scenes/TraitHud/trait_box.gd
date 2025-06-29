class_name TraitBox extends Control

enum TraitNames {
	LOVER,
	BROTHER,
	NOMAD,
	WHEEZER,
	CROAKER,
	EXPLORER,
}

@onready var trait_label: Label = $TraitLabel
@onready var trait_badge = $Visuals/Badge

@export var trait_name: TraitNames = TraitNames.LOVER
@export var trait_thresholds: Array[int] = [2]
@export var trait_label_name: String = "Lovers"
@export var current_trait_level: int = 0
@export var image: Texture2D = preload("res://Scenes/TraitHud/Badges/badge_lovers.png")

func _ready():
	# Construct string for trait label e.g 0/2 Lovers
	trait_label.text = "%d/%d %s" % [current_trait_level, trait_thresholds[-1], trait_label_name]
	trait_badge.texture = image

func update_trait_level(change: int) -> void:
	current_trait_level += change
	if current_trait_level < 0:
		current_trait_level = 0
	
	trait_label.text = "%d/%d %s" % [current_trait_level, trait_thresholds[-1], trait_label_name]	

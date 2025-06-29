class_name TraitBox extends Control

enum TraitNames {
	CROAKER,
	EXPLORER,
	LOVER,
	BROTHER,
	NOMAD,
	WHEEZER,
}
@onready var trait_label: Label = $TraitLabel
@onready var trait_badge = $Visuals/Badge

@export var trait_name: TraitNames = TraitNames.LOVER
@export var trait_thresholds: Array[int] = [2]
@export var trait_label_name: String = "Lovers"
@export var staring_trait_level: int = 0
@export var image: Texture2D = preload("res://Scenes/TraitHud/Badges/badge_lovers.png")


func _ready():
	# Construct string for trait label e.g 0/2 Lovers
	trait_label.text = "%d/%d %s" % [staring_trait_level, trait_thresholds[-1], trait_label_name]
	trait_badge.texture = image
			

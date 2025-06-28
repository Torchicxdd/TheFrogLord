class_name DamageComponent extends Node2D

@export var damage = 50
@export var lifesteal = 0

func deal_damage(target: Node) -> void:
	var health_component = target.get_node_or_null("HealthComponent") as HealthComponent
	if health_component != null:
		health_component.damage(damage)

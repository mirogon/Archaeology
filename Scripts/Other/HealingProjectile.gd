extends Area2D

export var heal_value: int = 5
export var move_speed: int = 100
var move_dir: Vector2

func _process(delta):
	position += move_dir * delta * move_speed

func _on_HealingProjectile_area_entered(area):
	if area.is_in_group("Soldier"):
		var health_system: HealthSystem = area.get_node("HealthSystem")
		health_system.restore_health(heal_value)
		queue_free()

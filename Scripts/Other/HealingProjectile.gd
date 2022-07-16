extends Area2D

export var heal_value: int = 5

func _on_Syringe_area_entered(area):
	if area.is_in_group("Soldier"):
		var health_system: HealthSystem = area.get_node("HealthSystem")
		health_system.restore_health(heal_value)
		area.play_heal_sound()
		queue_free()

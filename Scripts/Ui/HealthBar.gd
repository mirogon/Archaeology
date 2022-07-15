extends ProgressBar

func _on_HealthSystem_health_update(new_health):
	max_value = get_parent().get_node("HealthSystem").max_health
	value = new_health

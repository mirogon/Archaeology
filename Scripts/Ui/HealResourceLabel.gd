extends Label

func _on_Player_heal_resource_update(new_heal_resources):
	text = "Heal Resources: " + String(new_heal_resources)

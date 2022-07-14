extends Control

func _ready():
	$TextureProgress.value = 0

func _on_Player_heal_resource_update(new_heal_resources):
	var max_health_resources = get_tree().get_root().get_node("Main").get_node("Player").max_heal_resources
	var max_r: float = max_health_resources
	var current: float = new_heal_resources
	var percentage: float = (float(new_heal_resources) / float (max_r)) * float(100)
	$TextureProgress.value = percentage

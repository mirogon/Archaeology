extends ProgressBar

func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass


func _on_HealthSystem_health_update(new_health):
	max_value = get_parent().get_node("HealthSystem").max_health
	value = new_health

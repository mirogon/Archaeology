extends ProgressBar

func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass

func _on_HealthSystem_took_damage(new_health):
	value = new_health

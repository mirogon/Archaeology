extends KinematicBody2D

func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass


func _on_HealthSystem_died():
	print("Snake ded")
	queue_free()

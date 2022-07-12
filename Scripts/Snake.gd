extends KinematicBody2D

var time = 0
var last_time_hit = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	time += delta
	if time - last_time_hit > 0.1:
		$AnimatedSprite.modulate = Color(1,1,1,1)



func _on_HealthSystem_died():
	print("Snake ded")
	queue_free()


func _on_HealthSystem_health_update(new_health):
	$AnimatedSprite.modulate = Color(1,0,0,1)
	last_time_hit = time

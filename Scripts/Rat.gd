extends KinematicBody2D

export var speed = 75
var player
var soldier

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	soldier = get_tree().get_root().get_node("Main").get_node("Soldier")	

func _physics_process(delta):
	if position.distance_to(soldier.position) > 15:
		var dir = (soldier.position - position).normalized()
		move_and_slide(dir * speed)
		$AnimatedSprite.animation = "Rat_Walk"
		
		if position.x > soldier.position.x:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.animation = "Rat_Atk"
		var player_health_system = soldier.get_node("HealthSystem") as HealthSystem
		player_health_system.take_damage(1)

func _process(delta):
	pass

func _on_HealthSystem_died():
	print("Rat died")
	queue_free()

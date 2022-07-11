extends KinematicBody2D

export var speed = 75
export var damage_per_attack = 10
export var attack_interval = 1.0
var player
var soldier

var time = 0

var last_time_attacked = 0

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	soldier = get_tree().get_root().get_node("Main").get_node("Soldier")	

func _physics_process(delta):
	if position.distance_to(soldier.position) > 15:
		var dir = (soldier.position - position).normalized()
		move_and_slide(dir * speed)
		$AnimatedSprite.play("Rat_Walk")
		
		if position.x > soldier.position.x:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	else:
		if time - last_time_attacked > attack_interval:
			$AnimatedSprite.play("Rat_Atk")
			var player_health_system = soldier.get_node("HealthSystem") as HealthSystem
			player_health_system.take_damage(damage_per_attack)
			last_time_attacked = time

func _process(delta):
	time += delta

func _on_HealthSystem_died():
	print("Rat died")
	queue_free()

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.playing = false

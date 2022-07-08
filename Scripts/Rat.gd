extends KinematicBody2D

export var speed = 75
var player

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")

func _physics_process(delta):
	if position.distance_to(player.position) > 15:
		var dir = (player.position - position).normalized()
		move_and_slide(dir * speed)
		$AnimatedSprite.animation = "Rat_Walk"
		
		if position.x > player.position.x:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.animation = "Rat_Atk"
		var player_health_system = player.get_node("HealthSystem") as HealthSystem
		player_health_system.take_damage(100)

func _process(delta):
	pass

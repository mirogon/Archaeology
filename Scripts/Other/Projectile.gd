extends Area2D

class_name Projectile

export var hit_damage: int = 10
export var move_speed: int = 150
var moveDir: Vector2

func _ready():
	$AnimatedSprite.frame = 0

func _process(delta):
	position += moveDir * delta * move_speed

func _on_Projectile_body_entered(body):
	if body.is_in_group("Enemy"):
		$AnimatedSprite.play("Vase_Breaking")
		var healthSystem: HealthSystem = body.get_node("HealthSystem") as HealthSystem
		healthSystem.take_damage(hit_damage)
		move_speed = 0
	elif body is TileMap:
		$AnimatedSprite.play("Vase_Breaking")
		move_speed = 0

func _on_AnimatedSprite_animation_finished():
	queue_free()

func _on_DespawnTimer_timeout():
	queue_free()

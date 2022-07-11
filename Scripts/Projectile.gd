extends Area2D

class_name Projectile

export var hitDamage = 10
export var moveSpeed = 150

var moveDir: Vector2

func _ready():
	$AnimatedSprite.frame = 0

func _process(delta):
	position += moveDir * delta * moveSpeed

func _on_Projectile_body_entered(body):
	if body.is_in_group("Enemy"):
		$AnimatedSprite.play("Vase_Breaking")
		var healthSystem = body.get_node("HealthSystem") as HealthSystem
		healthSystem.take_damage(hitDamage)
		moveSpeed = 0

func _on_AnimatedSprite_animation_finished():
	queue_free()

func _on_DespawnTimer_timeout():
	queue_free()

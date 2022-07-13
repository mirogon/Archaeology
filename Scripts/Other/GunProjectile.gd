extends Area2D

class_name GunProjectile

export var hitDamage = 50
export var moveSpeed = 150

var moveDir: Vector2

func _ready():
	pass

func _process(delta):
	position += moveDir * delta * moveSpeed

func _on_Projectile_body_entered(body):
	if body.is_in_group("Enemy"):
		var healthSystem = body.get_node("HealthSystem") as HealthSystem
		healthSystem.take_damage(hitDamage)
		queue_free()

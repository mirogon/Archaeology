extends Area2D

export var heal_value = 5
export var move_speed = 100
var move_dir: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	position += move_dir * delta * move_speed

func _on_HealingProjectile_area_entered(area):
	if area.is_in_group("Soldier"):
		var health_system: HealthSystem = area.get_node("HealthSystem")
		health_system.restore_health(heal_value)
		queue_free()

extends Node

class_name HealthSystem

signal died
signal health_update(new_health)

export var max_health: int = 100
var current_health: int
var dead: bool

func _ready():
	current_health = max_health
	dead = false

func reset():
	current_health = max_health
	dead = false
	emit_signal("health_update", current_health)

func take_damage(damage: int):
	if(current_health == 0):
		return
	current_health -= damage
	if(current_health <= 0):
		current_health = 0
		dead = true
		emit_signal("died")
	emit_signal("health_update", current_health)

func restore_health(value: int):
	if dead:
		return
	current_health += value
	if current_health > max_health:
		current_health = max_health
	emit_signal("health_update", current_health)

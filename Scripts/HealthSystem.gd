extends Node

class_name HealthSystem

signal died
signal took_damage(new_health)

export var max_health: int = 100
var current_health
var dead

func _ready():
	current_health = max_health
	dead = false

func take_damage(damage: int):
	if(current_health == 0):
		return
	current_health -= damage
	if(current_health <= 0):
		current_health = 0
		dead = true
		emit_signal("died")
	emit_signal("took_damage", current_health)

func restore_health(value: int):
	if dead:
		return
	current_health += value
	if current_health > max_health:
		current_health = max_health

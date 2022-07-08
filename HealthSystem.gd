extends Node

class_name HealthSystem

signal died
signal took_damage(new_health)

export var max_health: int = 100
var current_health

func _ready():
	current_health = max_health

func take_damage(damage: int):
	current_health -= damage
	if(current_health < 0):
		current_health = 0
		emit_signal("died")
	emit_signal("took damage", current_health)

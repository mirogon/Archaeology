extends Area2D

export var heal_per_tick = 2

var in_area: Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_HealingArea_area_entered(area):
	if area is Soldier:
		var soldier = area as Soldier
		in_area.append(soldier)


func _on_HealingArea_area_exited(area):
	if area is Soldier:
		var s = area as Soldier
		in_area.erase(s)


func _on_HealTickTimer_timeout():
	for i in range(in_area.size()):
		in_area[i].get_node("HealthSystem").restore_health(heal_per_tick)



func _on_AliveTimer_timeout():
	queue_free()

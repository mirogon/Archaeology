extends Node2D

signal treasure_update(new_treasure)
signal enemies_died(enemies_died)

var enemies_died = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func enemy_died():
	enemies_died += 1
	emit_signal("enemies_died", enemies_died)

func _on_Player_treasure_update(treasure_found):
	emit_signal("treasure_update", treasure_found)

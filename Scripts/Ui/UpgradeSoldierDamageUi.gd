extends HBoxContainer

signal upgrade_soldier_damage_button_pressed

var upgrade_level = 0
var max_upgrade_level = 8

func _ready():
	get_child(9).get_child(0).connect("pressed", self, "on_upgrade_pressed")
	get_tree().get_root().get_node("Main").connect("upgraded_soldier_damage", self, "on_upgraded_soldier_damage")

func on_upgrade_pressed():
	if upgrade_level == max_upgrade_level:
		return
	emit_signal("upgrade_soldier_damage_button_pressed")

func on_upgraded_soldier_damage():
		upgrade_level += 1
		get_child(upgrade_level).get_child(0).modulate = Color(0.94,0.95,0.32,1)

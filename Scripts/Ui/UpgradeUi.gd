extends Control

signal upgrade_soldier_health_button_pressed
signal upgrade_soldier_damage_button_pressed
signal upgrade_soldier_speed_button_pressed
signal upgrade_player_heal_resource_button_pressed

func _ready():
	$TreasureLabel.text = String(0)
	get_tree().get_root().get_node("Main").connect("treasure_stored", self, "on_treasure_stored")

func on_treasure_stored(sum):
	$TreasureLabel.text = String(sum)

func _on_LifeUpgrade_upgrade_soldier_health_button_pressed():
	emit_signal("upgrade_soldier_health_button_pressed")


func _on_AtkUpgrade_upgrade_soldier_damage_button_pressed():
	emit_signal("upgrade_soldier_damage_button_pressed")


func _on_SpeedUpgrade_upgrade_soldier_speed_button_pressed():
	emit_signal("upgrade_soldier_speed_button_pressed")

func _on_HealResourceUpgrade_upgrade_player_heal_resource_button_pressed():
	emit_signal("upgrade_player_heal_resource_button_pressed")

extends Control

class_name UpgradeUi

signal upgrade_soldier_health_button_pressed
signal upgrade_soldier_damage_button_pressed
signal upgrade_soldier_speed_button_pressed
signal upgrade_player_heal_resource_button_pressed
signal reset_upgrades_button_pressed

func _ready():
	$TreasureLabel.text = String(0)
	get_tree().get_root().get_node("Main").connect("treasure_stored", self, "on_treasure_stored")

func on_treasure_stored(sum):
	$TreasureLabel.text = String(sum)

func upgrade_button_pressed(upgrade_name):
	
	$UpgradeSound.play()
	
	match upgrade_name:
		"soldier_health":
			emit_signal("upgrade_soldier_health_button_pressed")
		"soldier_damage":
			emit_signal("upgrade_soldier_damage_button_pressed")
		"soldier_speed":
			emit_signal("upgrade_soldier_speed_button_pressed")
		"player_heal_resource":
			emit_signal("upgrade_player_heal_resource_button_pressed")


func _on_ResetButton_pressed():
	emit_signal("reset_upgrades_button_pressed")

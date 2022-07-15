extends Node

class_name UpgradeState

export var max_upgrade = 8

var soldier_health_upgrade_state: int = 0
var soldier_damage_upgrade_state: int = 0
var soldier_speed_upgrade_state: int = 0
var player_heal_resource_upgrade_state: int = 0

func from_save_state(save_data):
	soldier_health_upgrade_state = save_data["soldier_health_upgrade_state"]
	soldier_damage_upgrade_state = save_data["soldier_damage_upgrade_state"]
	soldier_speed_upgrade_state = save_data["soldier_speed_upgrade_state"]
	player_heal_resource_upgrade_state = save_data["player_heal_resource_upgrade_state"]
	
func upgrade_soldier_health(treasure):
	var price: int = calculate_price(soldier_health_upgrade_state)
	if price > treasure:
		return -1
	if soldier_health_upgrade_state >= 8:
		return -1
	soldier_health_upgrade_state += 1
	return price

func upgrade_soldier_damage(treasure):
	var price: int = calculate_price(soldier_damage_upgrade_state)
	if price > treasure:
		return -1
	if soldier_damage_upgrade_state >= 8:
		return -1
	soldier_damage_upgrade_state += 1
	return price

func upgrade_soldier_speed(treasure):
	var price: int = calculate_price(soldier_speed_upgrade_state)
	if price > treasure:
		return -1
	if soldier_speed_upgrade_state >= 8:
		return -1
	soldier_speed_upgrade_state += 1
	return price

func upgrade_player_heal_resource(treasure):
	var price: int = calculate_price(player_heal_resource_upgrade_state)
	if price > treasure:
		return -1
	if player_heal_resource_upgrade_state >= 8:
		return -1
	player_heal_resource_upgrade_state += 1
	return price

func calculate_price(current_upgrade_state):
	return 10 + 10 * current_upgrade_state

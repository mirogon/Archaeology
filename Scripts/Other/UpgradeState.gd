extends Node

class_name UpgradeState

export var max_upgrade = 8

var soldier_health_upgrade_state = 0
var soldier_damage_upgrade_state = 0
var soldier_speed_upgrade_state = 0

var player_health_resource_upgrade_state = 0

func upgrade_soldier_health():
	if soldier_health_upgrade_state >= 8:
		return false
	soldier_health_upgrade_state += 1
	return true

func upgrade_soldier_damage():
	if soldier_damage_upgrade_state >= 8:
		return false
	soldier_damage_upgrade_state += 1
	return true

func upgrade_soldier_speed():
	if soldier_speed_upgrade_state >= 8:
		return false
	soldier_speed_upgrade_state += 1
	return true

func upgrade_player_health_resource():
	if player_health_resource_upgrade_state >= 8:
		return false
	player_health_resource_upgrade_state += 1
	return true

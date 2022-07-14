extends Node2D

signal treasure_update(new_treasure)
signal enemies_died(enemies_died)
signal restart_game()

signal upgraded_soldier_health
signal upgraded_soldier_damage
signal upgraded_soldier_speed
signal upgraded_player_health_resource

var room_scene = load("res://Scenes/Rooms/Room.tscn")
var loaded_room

var enemies_died = 0

var upgrade_state = UpgradeState.new()

func _ready():
	player_and_soldier_to_start()
	loaded_room = $Room
	randomize()
	
func restart_game():
	loaded_room.queue_free()
	loaded_room = room_scene.instance()
	add_child(loaded_room)
	
	$Player.restart_game()
	$Soldier.restart_game()
	player_and_soldier_to_start()
	
	$UiCanvasLayer.restart_game()
	
	emit_signal("restart_game")
	
	get_tree().paused = false

func player_and_soldier_to_start():
	$Player.position = $Room/PlayerStart.position
	$Soldier.position = $Room/PlayerStart.position
	
func enemy_died():
	enemies_died += 1
	emit_signal("enemies_died", enemies_died)

func _on_Player_treasure_update(treasure_found):
	emit_signal("treasure_update", treasure_found)

func _on_UpgradeUi_upgrade_soldier_health_button_pressed():
	if upgrade_state.upgrade_soldier_health():
		emit_signal("upgraded_soldier_health")
		$Soldier.get_node("HealthSystem").max_health = 100 + 100 * 0.25 * upgrade_state.soldier_health_upgrade_state

func _on_UpgradeUi_upgrade_soldier_damage_button_pressed():
	if upgrade_state.upgrade_soldier_damage():
		emit_signal("upgraded_soldier_damage")
		$Soldier.damage_per_hit = 25 + 5 * upgrade_state.soldier_damage_upgrade_state

func _on_UpgradeUi_upgrade_soldier_speed_button_pressed():
	if upgrade_state.upgrade_soldier_speed():
		emit_signal("upgraded_soldier_speed")
		$Soldier.get_node("NavigationMovement").moveSpeed = 75 + 75 * 0.15 * upgrade_state.soldier_speed_upgrade_state

func _on_UpgradeUi_upgrade_player_health_resource_button_pressed():
	if upgrade_state.upgrade_player_health_resource():
		emit_signal("upgraded_player_health_resource")
		$Player.max_heal_resources = 250 + 25 * upgrade_state.player_health_resource_upgrade_state

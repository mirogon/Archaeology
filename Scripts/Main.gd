extends Node2D

signal treasure_update(new_treasure)
signal enemies_died(enemies_died)

signal upgraded_soldier_health
signal upgraded_soldier_damage
signal upgraded_soldier_speed
signal upgraded_player_heal_resource

signal restart_game
signal loaded_savegame(upgrade_state)
signal treasure_stored(sum_treasure)

var room_scene = load("res://Scenes/Rooms/Room.tscn")
var room2_scene = load("res://Scenes/Rooms/Room2.tscn")
var loaded_room: Node

var enemies_died: int = 0
var treasure_stored: int = 0

var upgrade_state: UpgradeState = UpgradeState.new()

var rooms_visited: int = 0

func _ready():
	load_game()
	set_loaded_room($Room)
	player_and_soldier_to_start()	
	randomize()
	
	$Soldier.get_node("HealthSystem").connect("died", self, "on_game_over")
	$Player.get_node("HealthSystem").connect("died", self, "on_game_over")

func set_loaded_room(new_room):
	loaded_room = new_room
	new_room.connect("entered_room_traverser", self, "go_to_next_room")
	
func on_game_over():
	treasure_stored += $Player.treasure_found
	emit_signal("treasure_stored", treasure_stored)
	save_game()
	
func go_to_next_room():
	for i in range(get_child_count()):
		if get_child(i).is_in_group("Room"):
			get_child(i).queue_free()
	
	set_loaded_room(room2_scene.instance()) 
	call_deferred("add_child", loaded_room)
	player_and_soldier_to_start()
	$Soldier.get_node("NavigationMovement").initialize($Soldier.get_node("AnimatedSprite"), loaded_room.get_node("Navigation2D"))
	
func restart_game():
	loaded_room.queue_free()
	set_loaded_room(room_scene.instance())
	add_child(loaded_room)
	
	$Player.restart_game()
	$Soldier.restart_game()
	player_and_soldier_to_start()
	
	$UiCanvasLayer.restart_game()
	
	emit_signal("restart_game")
	
	get_tree().paused = false

func player_and_soldier_to_start():
	$Player.position = loaded_room.get_node("PlayerStart").position
	$Soldier.position = loaded_room.get_node("PlayerStart").position
	
func enemy_died():
	enemies_died += 1
	emit_signal("enemies_died", enemies_died)

func save_game():
	var save_data = {
		"soldier_health_upgrade_state" : upgrade_state.soldier_health_upgrade_state,
		"soldier_damage_upgrade_state" : upgrade_state.soldier_damage_upgrade_state,
		"soldier_speed_upgrade_state" : upgrade_state.soldier_speed_upgrade_state,
		"player_heal_resource_upgrade_state" : upgrade_state.player_heal_resource_upgrade_state,
		"treasure": treasure_stored
	}
	var file: File = File.new()
	
	file.open("user://savegame.save", File.WRITE)
	file.store_line(to_json(save_data))
	file.close()
	
func load_game():
	var file: File = File.new()
	if not file.file_exists("user://savegame.save"):
		return
	
	file.open("user://savegame.save", File.READ)
	var data = parse_json(file.get_line())
	upgrade_state.from_save_state(data)
	treasure_stored = data["treasure"]
	emit_signal("loaded_savegame", upgrade_state)

func _on_Player_treasure_update(treasure_found):
	emit_signal("treasure_update", treasure_found)

func _on_UpgradeUi_upgrade_soldier_health_button_pressed():
	var r: int = upgrade_state.upgrade_soldier_health(treasure_stored)
	if r == -1:
		return
	treasure_stored -= r
	emit_signal("upgraded_soldier_health")
	emit_signal("treasure_stored", treasure_stored)
	$Soldier.get_node("HealthSystem").max_health = 100 + 100 * 0.25 * upgrade_state.soldier_health_upgrade_state
	save_game()

func _on_UpgradeUi_upgrade_soldier_damage_button_pressed():
	var r: int = upgrade_state.upgrade_soldier_damage(treasure_stored)
	if r == -1:
		return
	treasure_stored -= r
	emit_signal("upgraded_soldier_damage")
	emit_signal("treasure_stored", treasure_stored)
	$Soldier.damage_per_hit = 25 + 5 * upgrade_state.soldier_damage_upgrade_state
	save_game()

func _on_UpgradeUi_upgrade_soldier_speed_button_pressed():
	var r: int = upgrade_state.upgrade_soldier_speed(treasure_stored)
	if r == -1:
		return
	treasure_stored -= r
	emit_signal("upgraded_soldier_speed")
	emit_signal("treasure_stored", treasure_stored)
	$Soldier.get_node("NavigationMovement").moveSpeed = 75 + 75 * 0.15 * upgrade_state.soldier_speed_upgrade_state
	save_game()

func _on_UpgradeUi_upgrade_player_heal_resource_button_pressed():
	var r: int = upgrade_state.upgrade_player_heal_resource(treasure_stored)
	if r == -1:
		return
	treasure_stored -= r
	emit_signal("upgraded_player_heal_resource")
	emit_signal("treasure_stored", treasure_stored)
	$Player.max_heal_resources = 250 + 25 * upgrade_state.player_heal_resource_upgrade_state
	save_game()

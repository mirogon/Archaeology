extends Node2D

signal treasure_update(new_treasure)
signal enemies_died(enemies_died)
signal restart_game()

var room_scene = load("res://Scenes/Rooms/Room.tscn")
var loaded_room

var enemies_died = 0

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

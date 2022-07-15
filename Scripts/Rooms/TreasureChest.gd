extends Area2D

class_name TreasureChest

export var item_spawn_movement: PackedScene
export var coin_scene: PackedScene
export var ruby_scene: PackedScene
export var min_coin_spawns = 2
export var max_coin_spawns = 6
export var min_ruby_spawns = 1
export var max_ruby_spawns = 3

var open = false

var time = 0
var time_opened = 0

func _ready():
	$OpenTimer.connect("timeout", self, "on_opentimer_timeout")

func open_chest():
	if open:
		return
	$AnimatedSprite.play("Chest_Open")
	open = true
	$OpenTimer.start()

func spawn_items():
	spawn_item(coin_scene, min_coin_spawns, max_coin_spawns)
	spawn_item(ruby_scene, min_ruby_spawns, max_ruby_spawns)

func spawn_item(item_scene, min_spawns, max_spawns):
	var spawns = (randi() % (max_spawns-min_spawns)) + min_spawns
	for i in range(spawns):
		var item = item_scene.instance()
		item.position = position
		item.add_child(item_spawn_movement.instance())
		get_parent().get_node("Pickups").add_child(item)
	
func on_opentimer_timeout():
	spawn_items()

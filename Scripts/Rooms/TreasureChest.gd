extends Area2D

class_name TreasureChest

export var item_spawn_movement: PackedScene
export var coin_scene: PackedScene
export var ruby_scene: PackedScene
export var min_coin_spawns: int = 2
export var max_coin_spawns: int = 6
export var min_ruby_spawns: int = 1
export var max_ruby_spawns: int = 3

var open: int = false

var time: float = 0
var time_opened: float = 0

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
	var spawns: int = (randi() % (max_spawns-min_spawns)) + min_spawns
	for i in range(spawns):
		var item: Node = item_scene.instance()
		item.position = position
		item.add_child(item_spawn_movement.instance())
		get_parent().get_node("Pickups").add_child(item)
	
func on_opentimer_timeout():
	spawn_items()

extends Area2D

class_name TreasureChest

export var item_spawn_movement: PackedScene
export var coin_scene: PackedScene
export var max_spawns = 6

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
	var num_items = (randi() % max_spawns) + 1
	for i in range(num_items):
		var coin = coin_scene.instance()
		coin.add_child(item_spawn_movement.instance())
		coin.position = position
		get_parent().get_node("Pickups").add_child(coin)
	
func on_opentimer_timeout():
	spawn_items()

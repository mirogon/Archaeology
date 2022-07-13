extends Area2D

class_name TreasureChest

export var item_spawn_movement: PackedScene
export var coin_scene: PackedScene
export var max_spawns = 6

var open = false

func _ready():
	pass # Replace with function body.

func open_chest():
	if open:
		return
	$AnimatedSprite.play("Chest_Open")
	open = true
	spawn_items()
	
func spawn_items():
	var num_items = (randi() % max_spawns) + 1
	for i in range(num_items):
		var coin = coin_scene.instance()
		coin.add_child(item_spawn_movement.instance())
		coin.position = position
		get_parent().get_node("Pickups").add_child(coin)
	
#func _process(delta):
#	pass

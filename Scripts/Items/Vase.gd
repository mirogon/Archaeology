extends Area2D

class_name Vase

export var coin_scene: PackedScene 
export var coin_drop_chance = 50

func _ready():
	pass # Replace with function body.

func break_vase():
	$AnimatedSprite.play("Vase_Break")

#func _process(delta):
#	pass

func _on_AnimatedSprite_animation_finished():
	var r = randi() % 100
	if r < coin_drop_chance:
		var coin = coin_scene.instance()
		coin.position = position
		var pickups = get_parent().get_node("Pickups")
		if pickups:
			pickups.add_child(coin)
	queue_free()

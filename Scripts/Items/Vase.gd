extends Area2D

class_name Vase

export var coin_scene: PackedScene 
export var coin_drop_chance: int = 50

func break_vase():
	$AnimatedSprite.play("Vase_Break")

func _on_AnimatedSprite_animation_finished():
	var r: int = randi() % 100
	if r < coin_drop_chance:
		var coin: Node2D = coin_scene.instance()
		coin.position = position
		var pickups: Node = get_parent().get_parent().get_node("Pickups")
		if pickups:
			pickups.add_child(coin)
	queue_free()

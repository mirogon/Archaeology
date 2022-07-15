extends Node2D

export var rotation_speed: float = 1.0

func _process(delta):
	get_parent().get_node("AnimatedSprite").rotation += delta * rotation_speed

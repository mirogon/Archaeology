extends Area2D

class_name HealParticle

export var move_speed: int = 200

var move_dir: Vector2

func _process(delta):
	position += move_dir * delta * move_speed

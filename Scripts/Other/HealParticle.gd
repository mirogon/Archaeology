extends Area2D

class_name HealParticle

export var move_speed = 200

var move_dir: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	position += move_dir * delta * move_speed

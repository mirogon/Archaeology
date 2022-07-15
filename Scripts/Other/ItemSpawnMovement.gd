extends Node

export var start_speed: int = 100
var random_dir: Vector2

func _ready():
	random_dir.y = 1
	random_dir.x = rand_range(-1, 1)
	get_parent().get_node("CollisionShape2D").disabled = true

func _process(delta):
	get_parent().position += random_dir * start_speed * delta

func _on_Timer_timeout():
	get_parent().get_node("CollisionShape2D").disabled = false
	self.queue_free()

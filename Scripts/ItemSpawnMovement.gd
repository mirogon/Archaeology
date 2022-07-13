extends Node

export var start_speed = 100

var random_dir: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	random_dir.y = 1
	random_dir.x = rand_range(-1, 1)
	get_parent().get_node("CollisionShape2D").disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().position += random_dir * start_speed * delta


func _on_Timer_timeout():
	get_parent().get_node("CollisionShape2D").disabled = false
	self.queue_free()

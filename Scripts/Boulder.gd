extends Area2D

export var hit_damage = 100
export var move_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(move_speed * delta, 0)

func _on_Boulder_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		var player = area.get_parent() as Player
		player.get_node("HealthSystem").take_damage(hit_damage)

	if area is Soldier:
		area.get_node("HealthSystem").take_damage(hit_damage)


func _on_Timer_timeout():
	self.queue_free()

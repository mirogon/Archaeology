extends Area2D

export var hit_damage: int = 100
export var move_speed: int = 200

func _process(delta):
	position += Vector2(move_speed * delta, 0)

func _on_Boulder_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		var player: Player = area.get_parent() as Player
		player.get_node("HealthSystem").take_damage(hit_damage)

	if area is Soldier:
		area.get_node("HealthSystem").take_damage(hit_damage)

func _on_Timer_timeout():
	self.queue_free()

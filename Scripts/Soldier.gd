extends Area2D

class_name Soldier

export var projectile_scene: PackedScene
export var shoot_interval = 1

var enemies: Array
var time_since_last_shot

func _ready():
	time_since_last_shot = 0

func _process(delta):
	find_enemies()
	if(enemies.size() > 0):
		var nearest_enemy = find_nearest_enemy()
		if time_since_last_shot >= shoot_interval:
			time_since_last_shot = 0
			shoot_at_enemy(nearest_enemy)
	time_since_last_shot += delta
				
func shoot_at_enemy(enemy):
	var direction: Vector2 = enemy.position - position
	direction = direction.normalized()
	var projectile = projectile_scene.instance()
	projectile.position = position
	projectile.moveDir = direction
	get_tree().get_root().add_child(projectile)
				
func find_nearest_enemy():
	if(!enemies || enemies.size() == 0):
		return
	var closest_enemy = enemies[0]
	for i in range(enemies.size()):
		if enemies[i].position.distance_to(position) < closest_enemy.position.distance_to(position):
			closest_enemy = enemies[i]
	return closest_enemy
	
func find_enemies():
	enemies.clear()
	var root_child_count = get_tree().get_root().get_child_count()
	for i in range(root_child_count):
		var child = get_tree().get_root().get_child(i)
		if(child.is_in_group("Enemy")):
			enemies.append(child)
		for j in range(child.get_child_count()):
			var child_child = child.get_child(j)
			if(child_child.is_in_group("Enemy")):
				enemies.append(child_child)
				
func _on_HealthSystem_died():
	print("Soldier died!")


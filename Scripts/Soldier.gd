extends Area2D

class_name Soldier

export var projectile_scene: PackedScene
export var attack_interval = 1.5

var enemies: Array
var focused_enemy

var time = 0
var last_time_destination_updated = 0

var currently_attacking = false
var last_time_attacked = 0

func _ready():
	$NavigationMovement.initialize($AnimatedSprite, get_parent().get_node("Navigation2D"))

func _process(delta):
	var focused_enemy = update_enemy_navigation_destination()
	attack_enemy(focused_enemy)
			
	time += delta

func update_enemy_navigation_destination():
	var focused_enemy = null
	if time - last_time_destination_updated > 0.5:
		last_time_destination_updated = time
		find_enemies()
		if(enemies.size() > 0):
			focused_enemy = find_nearest_enemy()
			if !currently_attacking:
				$NavigationMovement.set_new_destination(focused_enemy.position)
	return focused_enemy

func attack_enemy(enemy):
	if enemy:
		if position.distance_to(enemy.position) < 10:
			$NavigationMovement.active = false
			currently_attacking = true
			if time - last_time_attacked > attack_interval:
				if (enemy.position - position).x > 0:
					$AnimatedSprite.play("Army_ATK_Right")
				else:
					$AnimatedSprite.play("Army_ATK_Left")
						
				enemy.get_node("HealthSystem").take_damage(25)
				last_time_attacked = time
					
		else:
			$NavigationMovement.active = true
			currently_attacking = false
	
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
			for k in range(child_child.get_child_count()):
				var child_child_child = child_child.get_child(k)
				if(child_child_child.is_in_group("Enemy")):
					enemies.append(child_child_child)

func _on_HealthSystem_died():
	print("Soldier died")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Army_ATK_Right" || $AnimatedSprite.animation == "Army_ATK_Left":
		$AnimatedSprite.playing = false

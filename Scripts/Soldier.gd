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

var scheduled_attack = null

func _ready():
	$NavigationMovement.initialize($AnimatedSprite, get_parent().get_node("Room/Navigation2D"))

func restart_game():
	time = 0
	last_time_attacked = 0
	last_time_destination_updated = 0
	enemies = Array()
	focused_enemy = null
	enemies.clear()
	$HealthSystem.reset()
	
	var main = get_tree().get_root().get_node("Main")
	var room = null
	for i in range(main.get_child_count()):
		if main.get_child(i).is_in_group("Room"):
			room = main.get_child(i)
			
	$NavigationMovement.initialize($AnimatedSprite, room.get_node("Navigation2D"))

func _process(delta):
	focused_enemy = null
	if time - last_time_destination_updated > 0.5:
		focused_enemy = update_enemy_navigation_destination()
		last_time_destination_updated = time
	attack_enemy(focused_enemy)
			
	if scheduled_attack:
		if $AnimatedSprite.frame == 2:
			scheduled_attack.get_node("HealthSystem").take_damage(25)
			scheduled_attack = null
			
	time += delta

func update_enemy_navigation_destination():
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
			
				scheduled_attack = enemy			
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
	var main = get_tree().get_root().get_node("Main")
	var room = null
	for i in range(main.get_child_count()):
		if main.get_child(i).is_in_group("Room"):
			room = main.get_child(i)

	for i in range(room.get_node("Enemies").get_child_count()):
		enemies.append(room.get_node("Enemies").get_child(i))

func _on_HealthSystem_died():
	print("Soldier died")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Army_ATK_Right" || $AnimatedSprite.animation == "Army_ATK_Left":
		$AnimatedSprite.playing = false

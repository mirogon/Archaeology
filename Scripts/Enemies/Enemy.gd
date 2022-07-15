extends KinematicBody2D

export var moves = true
export var speed = 75
export var damage_per_attack = 10
export var attack_interval = 1.0
export var animation_name: String

export var coin_scene: PackedScene
export var ruby_scene: PackedScene

export var coin_drop_chance: int
export var ruby_drop_chance: int

var player
var soldier

var time = 0

var last_time_attacked = 0
var last_time_hit = 0


func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	soldier = get_tree().get_root().get_node("Main").get_node("Soldier")	
	
	$HealthSystem.connect("died", self, "on_died")
	$HealthSystem.connect("health_update", self, "on_health_update")
	$AnimatedSprite.connect("animation_finished", self, "on_animation_finished")
	
func _physics_process(delta):
	attack(soldier)

func attack(target):
	if position.distance_to(target.position) > 15:
		var dir = (target.position - position).normalized()
		if moves:
			move_and_slide(dir * speed)
		$AnimatedSprite.play(animation_name + "_Walk")
		
		if position.x > target.position.x:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	else:
		if time - last_time_attacked > attack_interval:
			$AnimatedSprite.play(animation_name + "_Atk")
			var target_health_system = target.get_node("HealthSystem") as HealthSystem
			target_health_system.take_damage(damage_per_attack)
			last_time_attacked = time

func _process(delta):
	time += delta
	if time - last_time_hit > 0.1:
		$AnimatedSprite.modulate = Color(1,1,1,1);

func on_died():
	queue_free()
	get_tree().get_root().get_node("Main").enemy_died()
	
	drop_item(coin_scene, coin_drop_chance)
	drop_item(ruby_scene, ruby_drop_chance)

func drop_item(item_scene, drop_chance):
	if !item_scene:
		return
	var random_num = randi() % 100
	if random_num <= drop_chance:
		var item = item_scene.instance()
		item.position = position
		get_parent().get_parent().add_child(item)


	
func on_health_update(new_health):
	$AnimatedSprite.modulate = Color(1,0,0,1)
	last_time_hit = time

func on_animation_finished():
	$AnimatedSprite.playing = false
extends Node2D

class_name OrbitingProjectiles

export var orbiting_scene: PackedScene
export var orbiting_radius: int = 80
export var orbiting_speed: int = 200
export var num_projectiles: int = 8

var orbiting_projectiles: Array
var current_rotation: float = 0

var started: bool = false

func start():
	if orbiting_projectiles.size() > 0:
		return false
	add_orbiting_projectiles(num_projectiles)
	started = true
	return true
	
func add_orbiting_projectiles(number):
	var angle_per_projectile: float = 360 / number
	for i in range(number):
		var new_projectile: Node2D = orbiting_scene.instance()
		new_projectile.position = position + Vector2(0, orbiting_radius).rotated(deg2rad(i * angle_per_projectile))
		var op = OrbitingProjectile.new()
		op.projectile = new_projectile
		op.current_rotation = i * angle_per_projectile
		orbiting_projectiles.append(op)
		add_child(new_projectile)

func _process(delta):
	if !started:
		return
	
	var to_remove: Array
	
	for i in range(orbiting_projectiles.size()):
		if orbiting_projectiles[i].projectile == null || !is_instance_valid(orbiting_projectiles[i].projectile):
			to_remove.append(orbiting_projectiles[i])
	
	for i in range(to_remove.size()):
		orbiting_projectiles.erase(to_remove[i])
	
	for i in range(orbiting_projectiles.size()):
		var p: Node2D = orbiting_projectiles[i].projectile
		var r: float = orbiting_projectiles[i].current_rotation
		p.position = position + Vector2(0, orbiting_radius).rotated(deg2rad(current_rotation + r))
		
	current_rotation += delta * orbiting_speed

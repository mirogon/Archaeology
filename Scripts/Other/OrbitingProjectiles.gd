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
	for i in range(num_projectiles):
		add_orbiting_projectile()
	started = true
	
func add_orbiting_projectile():
	var new_projectile: Node2D = orbiting_scene.instance()
	new_projectile.position = position + Vector2(0, orbiting_radius).rotated(deg2rad(current_rotation))
	orbiting_projectiles.append(new_projectile)
	add_child(new_projectile)

func remove_orbiting_projectile(projectile: Node):
	orbiting_projectiles.erase(projectile)

func _process(delta):
	if !started:
		return
		
	var angle_per_projectile: float = 360 / orbiting_projectiles.size()
	
	for i in range(orbiting_projectiles.size()):
		var current: Node2D = orbiting_projectiles[i]
		current.position = position + Vector2(0, orbiting_radius).rotated(deg2rad(current_rotation + angle_per_projectile * i))
		
	current_rotation += delta * orbiting_speed

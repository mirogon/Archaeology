extends Area2D

export var heal_value: int = 25
export var move_speed: int = 200
export var slope_speed: float = 0.03
export var sprite_rotation_speed: float = 4

var move_dir: Vector2 = Vector2(1, 0)
var move_dir_rotated: Vector2 = move_dir.rotated(deg2rad(90))

var move_dir_offset: float = -1
var move_dir_offset_change: float = -slope_speed

var last_time_modulated: float = 0
var modulation_is_red: bool = false

var time: float = 0

func _process(delta):
	move_dir_rotated = move_dir.rotated(deg2rad(90))
	sprite_rotate_and_modulation(delta)
	move(delta)	
	time += delta
	if time > 15:
		queue_free()

func sprite_rotate_and_modulation(delta):
	$Sprite.rotate(delta * sprite_rotation_speed)
	
	if time - last_time_modulated > 0.1:
		if modulation_is_red:
			$Sprite.modulate = Color(0,1,0,1)
			modulation_is_red = false
		else:
			$Sprite.modulate = Color(1,0,0,1)
			modulation_is_red = true
			
		last_time_modulated = time

func move(delta):
	move_dir_offset += move_dir_offset_change
	if move_dir_offset >= 1:
		move_dir_offset_change = -slope_speed
	elif move_dir_offset <= -1:
		move_dir_offset_change = slope_speed
	
	var md: Vector2 = move_dir + (move_dir_rotated * move_dir_offset)
	md = md.normalized()
	position += md * delta * move_speed

func _on_HealingBone_area_entered(area):
	if area is Soldier:
		var s: Soldier = area as Soldier
		s.get_node("HealthSystem").restore_health(heal_value)
		queue_free()

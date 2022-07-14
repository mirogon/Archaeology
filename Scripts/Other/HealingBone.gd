extends Area2D

export var heal_value = 25
export var move_speed = 200
export var slope_speed = 0.03
export var sprite_rotation_speed = 4

var move_dir: Vector2 = Vector2(1, 0)
var move_dir_rotated = move_dir.rotated(deg2rad(90))

var move_dir_offset = -1
var move_dir_offset_change = -slope_speed

var last_time_modulated = 0
var modulation_is_red = false

var time = 0

func _ready():
	#move_dir_offset = rand_range(-1, 1)
	pass

func _process(delta):
	move_dir_rotated = move_dir.rotated(deg2rad(90))
	$Sprite.rotate(delta * sprite_rotation_speed)
	
	if time - last_time_modulated > 0.1:
		if modulation_is_red:
			$Sprite.modulate = Color(0,1,0,1)
			modulation_is_red = false
		else:
			$Sprite.modulate = Color(1,0,0,1)
			modulation_is_red = true
			
		last_time_modulated = time
	
	move_dir_offset += move_dir_offset_change
	if move_dir_offset >= 1:
		move_dir_offset_change = -slope_speed
	elif move_dir_offset <= -1:
		move_dir_offset_change = slope_speed
	
	var md = move_dir + (move_dir_rotated * move_dir_offset)
	md = md.normalized()
	position += md * delta * move_speed
	
	time += delta
	if time > 15:
		queue_free()

func _on_HealingBone_area_entered(area):
	if area is Soldier:
		var s = area as Soldier
		s.get_node("HealthSystem").restore_health(heal_value)
		queue_free()

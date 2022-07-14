extends KinematicBody2D

class_name Player

signal heal_resource_update(new_heal_resources)
signal treasure_update(treasure_found)

export var movementSpeed = 100
export var projectileScene: PackedScene
export var healing_projectile_scene: PackedScene
export var healing_area_scene: PackedScene

export var max_heal_resources = 250

var heal_resources = 0
var treasure_found = 0

var time
var last_time_healing_area: float
var last_time_thrown_heal: float

var near_chest = null

func _ready():
	$ProgressBar.hide()
	time = 0
	
func restart_game():
	heal_resources = 0
	treasure_found = 0
	$HealthSystem.reset()
	

func get_movedir():
	var moveDir: Vector2 = Vector2(0,0)
	if(Input.is_action_pressed("ui_down")):
		moveDir += Vector2(0,1)
	if(Input.is_action_pressed("ui_up")):
		moveDir += Vector2(0,-1)
	if(Input.is_action_pressed("ui_left")):
		moveDir += Vector2(-1, 0)
	if(Input.is_action_pressed("ui_right")):
		moveDir += Vector2(1, 0)
	moveDir = moveDir.normalized()
	return moveDir
	
func set_anim(moveDir: Vector2):
	$AnimatedSprite.playing = true
	if(moveDir.x == 0 && moveDir.y == 0):
		$AnimatedSprite.animation = "Walk_Down"
		$AnimatedSprite.frame = 0
		$AnimatedSprite.playing = false
	if(moveDir.x > 0):
		$AnimatedSprite.animation = "Walk_Right"
		return
	elif(moveDir.x < 0):
		$AnimatedSprite.animation = "Walk_Left"
		return
	if(moveDir.y > 0):
		$AnimatedSprite.animation = "Walk_Down"
		return
	elif(moveDir.y < 0):
		$AnimatedSprite.animation = "Walk_Up"
		return

func movement():
	var moveDir: Vector2 = get_movedir()
	set_anim(moveDir)
	return moveDir
	
func _physics_process(delta):
	move_and_slide(movement() * movementSpeed)
			
func spawn_healing_area():
	if heal_resources < 25:
		return
	if Input.is_key_pressed(KEY_1):
		if time - last_time_healing_area > 1:
			var ha = healing_area_scene.instance()
			ha.position = get_global_mouse_position()
			get_tree().get_root().add_child(ha)
			last_time_healing_area = time
			heal_resources -= 25
	
func throw_healing_projectile():
	if(heal_resources < 25):
		return
	if Input.is_key_pressed(KEY_2) && (time - last_time_thrown_heal > 1):
		var healing_projectile = healing_projectile_scene.instance()
		var healing_projectile2 = healing_projectile_scene.instance()
		healing_projectile.position = position
		healing_projectile2.position = position
		var dir = get_global_mouse_position() - position
		dir = dir.normalized()
		healing_projectile.move_dir = dir 
		healing_projectile2.move_dir = dir
		healing_projectile.move_dir_offset = -1
		healing_projectile2.move_dir_offset = 1
		
		get_parent().add_child(healing_projectile)
		get_parent().add_child(healing_projectile2)
		last_time_thrown_heal = time
		heal_resources -= 25
		emit_signal("heal_resource_update", heal_resources)
	
func _process(delta):
	spawn_healing_area()
	throw_healing_projectile()
	time += delta
	
	if Input.is_action_just_pressed("action"):
		if near_chest:
			near_chest.open_chest()
			near_chest = null

func _on_HealthSystem_died():
	print("PLAYER DIED!")

func _on_HealthSystem_health_update(new_health):
	$ProgressBar.show()


func _on_Area2D_area_entered(area):
	if area.is_in_group("HealthPickup"):
		if heal_resources >= max_heal_resources:
			return
		var health_pickup = area as HealthPickup
		heal_resources += health_pickup.health_value
		emit_signal("heal_resource_update", heal_resources)
		area.queue_free()
	elif area.is_in_group("TreasurePickup"):
		var treasure = area as TreasurePickup
		treasure_found += treasure.treasure_value
		emit_signal("treasure_update", treasure_found)
		area.queue_free()
	elif area.is_in_group("TreasureChest"):
		near_chest = area as TreasureChest


func _on_Area2D_area_exited(area):
	if area.is_in_group("TreasureChest"):
		near_chest = null

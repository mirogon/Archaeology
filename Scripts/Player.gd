extends KinematicBody2D

class_name Player

signal heal_resource_update(new_heal_resources)
signal treasure_update(treasure_found)

export var movementSpeed = 100
export var projectileScene: PackedScene
export var healing_projectile_scene: PackedScene

var heal_resources = 0
var treasure_found = 0

var time
var last_time_thrown_projectile: float
var last_time_thrown_heal: float

func _ready():
	$ProgressBar.hide()
	time = 0

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
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0
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
			
func throw_projectile():
	if Input.is_mouse_button_pressed(1) && (time - last_time_thrown_projectile) > 1:
		var new_projectile = projectileScene.instance() as Projectile
		new_projectile.position = position
		var dir = get_global_mouse_position() - position
		dir = dir.normalized()
		new_projectile.moveDir = dir 
		get_parent().add_child(new_projectile)
		last_time_thrown_projectile = time
	
func throw_healing_projectile():
	if(heal_resources < 25):
		return
	if Input.is_mouse_button_pressed(2) && (time - last_time_thrown_heal > 1):
		var healing_projectile = healing_projectile_scene.instance()
		healing_projectile.position = position
		var dir = get_global_mouse_position() - position
		dir = dir.normalized()
		healing_projectile.move_dir = dir 
		get_parent().add_child(healing_projectile)
		last_time_thrown_heal = time
		heal_resources -= 25
		emit_signal("heal_resource_update", heal_resources)
	
func _process(delta):
	throw_projectile()
	throw_healing_projectile()
	time += delta

func _on_HealthSystem_died():
	print("PLAYER DIED!")

func _on_HealthSystem_health_update(new_health):
	$ProgressBar.show()


func _on_Area2D_area_entered(area):
	if area.is_in_group("HealthPickup"):
		print("picked up HealthPickup")
		var health_pickup = area as HealthPickup
		heal_resources += health_pickup.health_value
		emit_signal("heal_resource_update", heal_resources)
		area.queue_free()
	elif area.is_in_group("TreasurePickup"):
		var treasure = area as TreasurePickup
		treasure_found += treasure.treasure_value
		emit_signal("treasure_update", treasure_found)
		area.queue_free()

extends KinematicBody2D

class_name Player

export var movementSpeed = 100
export var projectileScene: PackedScene
export var healing_projectile_scene: PackedScene

var animatedSprite: AnimatedSprite

var time
var lastTimeThrownProjectile: float
var last_time_thrown_heal: float

func _ready():
	animatedSprite = $AnimatedSprite
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
	animatedSprite.playing = true
	if(moveDir.x == 0 && moveDir.y == 0):
		animatedSprite.playing = false
		animatedSprite.frame = 0
	if(moveDir.x > 0):
		animatedSprite.animation = "Walk_Right"
		return
	elif(moveDir.x < 0):
		animatedSprite.animation = "Walk_Left"
		return
	if(moveDir.y > 0):
		animatedSprite.animation = "Walk_Down"
		return
	elif(moveDir.y < 0):
		animatedSprite.animation = "Walk_Up"
		return

func movement():
	var moveDir: Vector2 = get_movedir()
	set_anim(moveDir)
	return moveDir
	
func _physics_process(delta):
	move_and_slide(movement() * movementSpeed)
	if(get_slide_count() > 0):
		var collision = get_slide_collision(0)
		if(collision):
			#print("Player collided with: ", collision.collider)
			var tileMap: TileMap = collision.collider as TileMap
			if(tileMap):
				var tilePos = tileMap.world_to_map(position)
				tilePos -= collision.normal
				var tileId = tileMap.get_cellv(tilePos)
				#var tileName = tileMap.tile_set.tile_get_name(tileId)
				#print(tileName)
			
func throw_projectile():
	if Input.is_mouse_button_pressed(1) && (time - lastTimeThrownProjectile) > 1:
		var new_projectile = projectileScene.instance() as Projectile
		new_projectile.position = position
		var dir = get_global_mouse_position() - position
		dir = dir.normalized()
		new_projectile.moveDir = dir 
		get_parent().add_child(new_projectile)
		lastTimeThrownProjectile = time
	
func throw_healing_projectile():
	if Input.is_mouse_button_pressed(2) && (time - last_time_thrown_heal > 1):
		var healing_projectile = healing_projectile_scene.instance()
		healing_projectile.position = position
		var dir = get_global_mouse_position() - position
		dir = dir.normalized()
		healing_projectile.move_dir = dir 
		get_parent().add_child(healing_projectile)
		last_time_thrown_heal = time
	
func _process(delta):
	throw_projectile()
	throw_healing_projectile()
	time += delta

func _on_HealthSystem_died():
	print("PLAYER DIED!")

func _on_HealthSystem_health_update(new_health):
	$ProgressBar.show()

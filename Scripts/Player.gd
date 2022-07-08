extends KinematicBody2D

class_name Player

export var movementSpeed = 100

var animatedSprite: AnimatedSprite

func _ready():
	animatedSprite = $AnimatedSprite

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
			
	
func _process(delta):
	#self.position += movement() * delta * movementSpeed
	pass


func _on_HealthSystem_died():
	#print("PLAYER DIED!")
	pass

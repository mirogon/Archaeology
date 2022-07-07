extends AnimatedSprite

export var movementSpeed = 100

func _ready():
	pass

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
	playing = true
	if(moveDir.x == 0 && moveDir.y == 0):
		playing = false
		frame = 0
	if(moveDir.x > 0):
		animation = "Walk_Right"
		return
	elif(moveDir.x < 0):
		animation = "Walk_Left"
		return
	if(moveDir.y > 0):
		animation = "Walk_Down"
		return
	elif(moveDir.y < 0):
		animation = "Walk_Up"
		return

func movement():
	var moveDir: Vector2 = get_movedir()
	set_anim(moveDir)
	return moveDir
	
func _process(delta):
	self.position += movement() * delta * movementSpeed
	pass

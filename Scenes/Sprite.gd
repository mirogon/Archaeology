extends Sprite

export var movementSpeed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func movement():
	var moveDir = Vector2(0,0)
	if(Input.is_action_pressed("ui_down")):
		moveDir += Vector2(0,1)
	if(Input.is_action_pressed("ui_up")):
		moveDir += Vector2(0,-1)
	if(Input.is_action_pressed("ui_left")):
		moveDir += Vector2(-1, 0)
	if(Input.is_action_pressed("ui_right")):
		moveDir += Vector2(1, 0)
	return moveDir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += movement() * delta * movementSpeed
	pass

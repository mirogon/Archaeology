extends KinematicBody2D

export var speed = 75
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")

func _physics_process(delta):
	if position.distance_to(player.position) > 15:
		#position = position.move_toward(player.position, speed * delta)
		var dir = (player.position - position).normalized()
		move_and_slide(dir * speed)
		$AnimatedSprite.animation = "Rat_Walk"
	else:
		$AnimatedSprite.animation = "Rat_Atk"

func _process(delta):
	pass

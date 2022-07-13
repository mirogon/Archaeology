extends Area2D

class_name TreasureChest

var open = false

func _ready():
	pass # Replace with function body.

func open_chest():
	if open:
		return
	$AnimatedSprite.play("Chest_Open")
	open = true
#func _process(delta):
#	pass

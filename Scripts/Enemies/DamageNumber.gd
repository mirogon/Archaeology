extends Node2D

func show_damage(damage):
	$Label.text = String(damage)
	self.visible = true
	$LifetimeTimer.start()
	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LifetimeTimer_timeout():
	self.visible = false

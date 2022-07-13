extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Soldier/HealthSystem").connect("died", self, "on_soldier_died")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_soldier_died():
	$Dead.visible = true
	$DeadLabel.visible = true
	get_tree().paused = true

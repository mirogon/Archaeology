extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().get_node("Main").connect("enemies_died", self, "on_enemies_died")


func on_enemies_died(enemies_died):
	text = String(enemies_died)

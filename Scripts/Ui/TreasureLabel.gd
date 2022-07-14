extends Label

func _ready():
	get_tree().get_root().get_node("Main").connect("treasure_update", self, "on_treasure_update")
	get_tree().get_root().get_node("Main").connect("restart_game", self, "restart_game")

func on_treasure_update(treasure_found):
	text = String(treasure_found)

func restart_game():
	text = "0"

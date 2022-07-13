extends Label

func _ready():
	get_tree().get_root().get_node("Main").connect("treasure_update", self, "on_treasure_update")

func on_treasure_update(treasure_found):
	text = String(treasure_found)

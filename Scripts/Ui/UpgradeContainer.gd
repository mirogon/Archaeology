extends HBoxContainer

export var upgrade_name: String

var upgrade_level: int = 0
var max_upgrade_level: int = 8

var upgrade_ui_node: UpgradeUi = null

func _ready():
	upgrade_ui_node = get_tree().get_root().get_node("Main").get_node("UiCanvasLayer").get_node("UpgradeUi")
	get_child(9).get_child(0).connect("pressed", self, "on_upgrade_pressed")
	get_tree().get_root().get_node("Main").connect("upgraded_" + upgrade_name, self, "on_upgraded")
	get_tree().get_root().get_node("Main").connect("loaded_savegame", self, "on_loaded_savegame")

func on_upgrade_pressed():
	if upgrade_level == max_upgrade_level:
		return
	upgrade_ui_node.upgrade_button_pressed(upgrade_name)

func on_upgraded():
		upgrade_level += 1
		get_child(upgrade_level).get_child(0).modulate = Color(0.94,0.95,0.32,1)

func on_loaded_savegame(upgrade_state: UpgradeState):
	upgrade_level = upgrade_state.get_upgrade_state(upgrade_name)
	for i in range(upgrade_level):
		get_child(i+1).get_child(0).modulate = 	Color(0.94,0.95,0.32,1)

extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Soldier/HealthSystem").connect("died", self, "on_soldier_died")
	get_parent().get_node("Player/HealthSystem").connect("died", self, "on_player_died")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func restart_game():
	$UpgradeUi.visible = false
	$MainUi.visible = true
	$HealthResourceBar.visible = true

func on_soldier_died():
	$UpgradeUi.visible = true
	$MainUi.visible = false
	$HealthResourceBar.visible = false
	get_tree().paused = true

func on_player_died():
	$UpgradeUi.visible = true
	$MainUi.visible = false
	$HealthResourceBar.visible = false
	get_tree().paused = true

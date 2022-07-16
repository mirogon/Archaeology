extends CanvasLayer

func restart_game():
	$UpgradeUi.visible = false
	$MainUi.visible = true
	$HealthResourceBar.visible = true

func show_upgrade_ui():
	$UpgradeUi.visible = true
	$MainUi.visible = false
	$HealthResourceBar.visible = false
	get_tree().paused = true

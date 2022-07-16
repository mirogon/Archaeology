extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var main: Node = get_tree().get_root().get_node("Main")
	var ui_canvas_layer: Node = main.get_node("UiCanvasLayer")
	if visible:
		if Input.is_key_pressed(KEY_ENTER):
			visible = false
			ui_canvas_layer.show_upgrade_ui()


func initialize(time_survived, enemies_killed, treasure_collected, rooms_visited):
	var minutes: int = time_survived / 600
	var minutes_string: String = create_minutes_string(minutes)
	var seconds: int = time_survived / 10
	var seconds_string: String = create_seconds_string(seconds)
	var tenth_seconds_string: String = create_tenth_seconds_string(time_survived)
		
	var time_string: String = minutes_string + ":" + seconds_string + ":" + tenth_seconds_string
	
	$MarginContainer/VBoxContainer/TimeSurvived.text = "Time Survived: " + time_string
	$MarginContainer/VBoxContainer/EnemiesKilled.text = "Enemies Killed: " + String(enemies_killed)
	$MarginContainer/VBoxContainer/TreasureCollected.text = "Treasure Collected: " + String(treasure_collected)
	$MarginContainer/VBoxContainer/RoomsVisited.text = "Rooms Visited: " + String(rooms_visited)
	$MarginContainer/VBoxContainer/Score.text = "Score: " + String(calculate_score(seconds, enemies_killed, treasure_collected, rooms_visited))

func calculate_score(time_survived_sec, enemies_killed, treasure_collected, rooms_visited):
	var score: int = 0
	score += 10 * time_survived_sec
	score += enemies_killed * 25
	score += treasure_collected * 10
	score += rooms_visited * 100
	return score
	
func create_minutes_string(minutes):
	var minutes_string: String = ""
	if(minutes < 10):
		minutes_string = "0" + String(minutes)
	else:
		minutes_string = String(minutes)
	return minutes_string

func create_seconds_string(seconds):
	var seconds_string: String = ""
	if(seconds%60 < 10):
		seconds_string = "0" + String(seconds%60)
	else:
		seconds_string = String(seconds%60)
	return seconds_string
	
func create_tenth_seconds_string(tenth_seconds):
	var tenth_seconds_string: String = ""
	if tenth_seconds%10 < 10:
		tenth_seconds_string = "0" + String(tenth_seconds%10)
	else:
		tenth_seconds_string = String(tenth_seconds%10)	
	return tenth_seconds_string

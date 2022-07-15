extends Label

var tenth_seconds: int = 0

func _ready():
	get_tree().get_root().get_node("Main").connect("restart_game", self, "restart_game")

func restart_game():
	tenth_seconds = 0

func _on_Timer_timeout():
	tenth_seconds += 1
	var minutes: int = tenth_seconds / 600
	var minutes_string: String = create_minutes_string(minutes)
	var seconds: int = tenth_seconds / 10
	var seconds_string: String = create_seconds_string(seconds)
	var tenth_seconds_string: String = create_tenth_seconds_string(tenth_seconds)
		
	var time_string: String = minutes_string + ":" + seconds_string + ":" + tenth_seconds_string
	
	self.text = time_string

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

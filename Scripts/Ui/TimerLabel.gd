extends Label

var tenth_seconds: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().get_node("Main").connect("restart_game", self, "restart_game")
	pass # Replace with function body.

func restart_game():
	tenth_seconds = 0

func _on_Timer_timeout():
	tenth_seconds += 1
	
	var minutes = tenth_seconds / 600
	var seconds = tenth_seconds / 10
	
	var minutes_string = ""
	if(minutes < 10):
		minutes_string = "0" + String(minutes)
	else:
		minutes_string = String(minutes)
		
	var seconds_string = ""
	if(seconds%60 < 10):
		seconds_string = "0" + String(seconds%60)
	else:
		seconds_string = String(seconds%60)
		
	var tenth_seconds_string = ""
	if tenth_seconds%10 < 10:
		tenth_seconds_string = "0" + String(tenth_seconds%10)
	else:
		tenth_seconds_string = String(tenth_seconds%10)	
		
	var time_string = minutes_string + ":" + seconds_string + ":" + tenth_seconds_string
	
	self.text = time_string

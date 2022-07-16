extends AudioStreamPlayer

export var sounds: Array

export var loop_delay: float = 1
var time: float = 0
var last_time_played: float = 0

var active = false

func start():
	active = true
	
func stop():
	active = false

func _process(delta):
	time += delta
	if !active:
		return
		
	if time - last_time_played >= loop_delay:
		set_random_sound()
		play()
		last_time_played = time

func set_random_sound():
	var r = randi() % sounds.size()
	var sound = sounds[r] as AudioStream
	stream = sound

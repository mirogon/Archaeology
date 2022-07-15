extends AudioStreamPlayer

export var sounds: Array

func set_random_sound():
	var r = randi() % sounds.size()
	var sound = sounds[r] as AudioStream
	stream = sound

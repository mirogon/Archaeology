extends Node2D

#Depending on ../../Enemies node

export var scene_to_spawn: PackedScene
export var min_interval_ms: int
export var max_interval_ms: int
export var max_spawns = 99

var current_interval = 0
var time_interval = 0
var spawns = 0

func _ready():
	current_interval = random_interval(min_interval_ms, max_interval_ms)

func random_interval(min_interval, max_interval):
	var r = rand_range(min_interval, max_interval)
	var interval_sec: float = r/1000
	return interval_sec

func _process(delta):
	if spawns >= max_spawns:
		return
	time_interval += delta
	if time_interval >= current_interval:
		time_interval = 0
		current_interval = random_interval(min_interval_ms, max_interval_ms)
		spawn()

func spawn():
	var instance = scene_to_spawn.instance()
	instance.position = position
	get_parent().get_parent().get_node("Enemies").add_child(instance)
	spawns += 1

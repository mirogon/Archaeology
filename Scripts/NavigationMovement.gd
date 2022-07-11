extends Node

export var moveSpeed = 100
export var mouse_debug_mode = false
export var animation_name: String

#Injected
var animated_sprite: AnimatedSprite
var navigation2D: Navigation2D

var current_destination: Vector2
var current_path: PoolVector2Array
var current_path_index: int
var destination_reached: bool

var initialized = false
var active = true

func _ready():
	destination_reached = true
	current_path_index = 0

func initialize(sprite: AnimatedSprite, nav2D: Navigation2D):
	animated_sprite = sprite
	navigation2D = nav2D
	initialized = true

func set_new_destination(dest: Vector2):
	current_destination = dest
	destination_reached = false
	get_new_path()
	animated_sprite.playing = true

func get_new_path():
	current_path = navigation2D.get_simple_path(get_parent().position, current_destination)
	current_path.remove(0)
	current_path_index = 0

func increment_path_index():
	current_path_index += 1
	print("increment")
	if(current_path_index >= current_path.size()):
		destination_reached = true
		current_path_index -= 1
		animated_sprite.playing = false

func get_current_path_point_destination():
	var distance_vector = current_path[current_path_index] - get_parent().position
	var distance_value = abs(distance_vector.length())
	
	if(distance_value < 2):
		increment_path_index()
		
	return current_path[current_path_index]

func move_closer_to(destination: Vector2, speed_times_delta: float):
	var dir: Vector2 = destination - get_parent().position
	dir = dir.normalized()
	set_animation(dir)
	get_parent().position += dir * speed_times_delta

func set_animation(dir: Vector2):
	if(dir.x > 0 && dir.x > abs(dir.y)):
		animated_sprite.animation = animation_name + "_Walk_Right"
		return
	if(dir.x < 0 && abs(dir.x) > abs(dir.y)):
		animated_sprite.animation = animation_name + "_Walk_Left"
		return
	if(dir.y > 0):
		animated_sprite.animation = animation_name + "_Walk_Down"
		return
	else:
		animated_sprite.animation = animation_name + "_Walk_Up"
		
func _process(delta):
	if(!active || !initialized):
		return
	
	if(destination_reached):
		return
	
	var current_path_point_destination = get_current_path_point_destination()
	move_closer_to(current_path_point_destination, moveSpeed * delta)

extends Node

export var moveSpeed: int = 100
export var mouse_debug_mode: bool = false
export var animation_name: String
export var set_animations: bool = false

#Injected
var animated_sprite: AnimatedSprite
var navigation2D: Navigation2D

var current_destination: Vector2
var current_path: PoolVector2Array
var current_path_index: int
var destination_reached: bool

var initialized: bool = false
var active: bool = true

func _ready():
	destination_reached = true
	current_path_index = 0

func initialize(sprite: AnimatedSprite, nav2D: Navigation2D):
	animated_sprite = sprite
	navigation2D = nav2D
	initialized = true
	destination_reached = true
	current_path_index = 0

func set_new_destination(dest: Vector2):
	current_destination = dest
	destination_reached = false
	get_new_path()
	if set_animations:
		animated_sprite.playing = true

func get_new_path():
	current_path = navigation2D.get_simple_path(get_parent().position, current_destination)
	current_path.remove(0)
	current_path_index = 0

func increment_path_index():
	current_path_index += 1
	if(current_path_index >= current_path.size()):
		destination_reached = true
		current_path_index -= 1
		if set_animations:
			animated_sprite.playing = false

func get_current_path_point_destination():
	var distance_vector: Vector2 = current_path[current_path_index] - get_parent().position
	var distance_value: float = abs(distance_vector.length())
	
	if(distance_value < 2):
		increment_path_index()
		
	return current_path[current_path_index]

func move_closer_to(destination: Vector2, speed: float, delta: float):
	var dir: Vector2 = destination - get_parent().position
	dir = dir.normalized()
	if set_animations:
		set_animation(dir)
	
	if get_parent() is KinematicBody2D:
		get_parent().move_and_slide(dir * speed)
	else:
		get_parent().position += dir * speed * delta

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
		
func _physics_process(delta):
	if(!active || !initialized):
		return
	
	if(destination_reached):
		return
	
	var current_path_point_destination: Vector2 = get_current_path_point_destination()
	move_closer_to(current_path_point_destination, moveSpeed, delta)

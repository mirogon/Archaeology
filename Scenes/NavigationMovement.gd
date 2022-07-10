extends Node

export var moveSpeed = 100
export var mouse_debug_mode = false

#Expects a Navigation2D in the running root scene
var navigation2D: Navigation2D

var current_destination: Vector2
var current_path: PoolVector2Array
var current_path_index: int
var destination_reached: bool

var active = false

func _ready():
	navigation2D = get_tree().get_root().get_node("Navigation2D")
	if(navigation2D):
		active = true
		
	destination_reached = false
	current_path_index = 0
	set_new_destination(Vector2(0,270))

func set_new_destination(dest: Vector2):
	current_destination = dest
	destination_reached = false
	get_new_path()

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
		

func get_current_path_point_destination():
	var distance_vector = current_path[current_path_index] - get_parent().position
	var distance_value = abs(distance_vector.length())
	
	if(distance_value < 2):
		increment_path_index()
		
	return current_path[current_path_index]

func move_closer_to(destination: Vector2, speed_times_delta: float):
	var dir: Vector2 = destination - get_parent().position
	dir = dir.normalized()
	get_parent().position += dir * speed_times_delta

func mouse_debug_mode_set_position():
	if Input.is_mouse_button_pressed(1):
		var parent = get_parent() as Node2D
		set_new_destination(parent.get_global_mouse_position())
		
func _process(delta):
	if(!active):
		return
		
	if(mouse_debug_mode):
		mouse_debug_mode_set_position()
	
	if(destination_reached):
		return
	
	var current_path_point_destination = get_current_path_point_destination()
	move_closer_to(current_path_point_destination, moveSpeed * delta)
	

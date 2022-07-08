extends Navigation2D
var closestPath
var currentPointIndex
var destination_reached
export var move_speed = 50

func _ready():
	
	closestPath = get_simple_path($Npc.position, $Goal.position)
	closestPath.remove(0)
	
	print(closestPath.size())
	for i in range(closestPath.size()):
		print(closestPath[i])
	currentPointIndex = 0
	destination_reached = false

func get_current_destination():
	var distance_to_point_vector: Vector2 = closestPath[currentPointIndex] - $Npc.position
	var distance_to_point: float = abs(distance_to_point_vector.length())
	if(distance_to_point < 10):
		currentPointIndex += 1
		if(currentPointIndex >= closestPath.size()):
			destination_reached = true
			currentPointIndex -= 1
	return closestPath[currentPointIndex]

func move_closer_to(destination: Vector2, speed_times_delta):
	var direction: Vector2 = destination - $Npc.position
	direction = direction.normalized()
	$Npc.position += direction * speed_times_delta

func _process(delta):
	if(!destination_reached):
		var next_destination = get_current_destination()
		move_closer_to(next_destination, move_speed * delta)

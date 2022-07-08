extends Navigation2D

var destination: Vector2
var npc
var closestPath
var currentPointIndex
var destination_reached

func _ready():
	var goalNode: Node2D = $Goal
	destination = goalNode.position

	npc = $Npc
	
	closestPath = get_simple_path(npc.position, destination)
	closestPath.remove(0)
	
	print(closestPath.size())
	for i in range(closestPath.size()):
		print(closestPath[i])
	currentPointIndex = 0
	destination_reached = false

func move_to_next_point():
	npc.position = closestPath[currentPointIndex]
	currentPointIndex += 1
	if(currentPointIndex >= closestPath.size()):
		destination_reached = true

func _process(delta):
	if(destination_reached == false):
		if(Input.is_action_just_pressed("ui_down")):
			move_to_next_point()

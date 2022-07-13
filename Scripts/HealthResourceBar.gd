extends Control

export var max_health_resources = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_heal_resource_update(new_heal_resources):
	var max_r: float = max_health_resources
	var current: float = new_heal_resources
	var percentage: float = (float(new_heal_resources) / float (max_r)) * float(100)
	$TextureProgress.value = percentage

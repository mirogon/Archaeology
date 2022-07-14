extends Node2D

var in_beam: Array

var active = false

func set_active(new_state):
	if !new_state:
		$HealParticles.emitting = false
	else:
		$HealParticles.emitting = true
	active = new_state

func _ready():
	set_active(false)
	
func _process(delta):
	var dir = get_global_mouse_position() - global_position
	dir = dir.normalized()
	rotation = dir.angle()

func _on_HealBeam_area_entered(area):
	if area is Soldier:
		var soldier = area as Soldier
		in_beam.append(soldier)
		
func _on_HealBeam_area_exited(area):
	if area is Soldier:
		var s = area as Soldier
		in_beam.erase(s)


func _on_HealTickTimer_timeout():
	if !active:
		return
	for i in range(in_beam.size()):
		in_beam[i].get_node("HealthSystem").restore_health(4)

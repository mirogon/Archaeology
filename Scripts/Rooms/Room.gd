extends Node2D

signal entered_room_traverser

var traversed: bool = false

func _ready():
	get_node("RoomTraverser").connect("area_entered", self, "on_room_traverser_entered")
	
func on_room_traverser_entered(area):
	if area.is_in_group("Player") && traversed == false:
		emit_signal("entered_room_traverser")
		traversed = true

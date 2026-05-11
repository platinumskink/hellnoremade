extends Node

@export var gravity_force: int

func _physics_process(delta: float) -> void:
	var parent := get_parent()
	if parent is GraphicalObject:
		parent.speed.y += gravity_force * delta
		if parent.turn:
			parent.turn_towards_direction()

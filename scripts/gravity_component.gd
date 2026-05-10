extends Node

var gravity_force: int = 1000

func _physics_process(delta: float) -> void:
	var parent := get_parent()
	if parent is GraphicalObject:
		parent.speed.y += gravity_force * delta
		print("gravity_force: "+ str(gravity_force))

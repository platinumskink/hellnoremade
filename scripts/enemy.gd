class_name Enemy
extends GraphicalObject

signal enemy_defeated(enemies_hit: int, score: int)

@export var points_worth: float

@export var min_speed: float
@export var max_speed: float
var defeated: bool = false


func get_random_speed() -> float:
	return randf_range(min_speed, max_speed)

func set_starting_speed(distance_vector: Vector2) -> void:
	speed = get_random_speed() * distance_vector

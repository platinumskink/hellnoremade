class_name Enemy
extends GraphicalObject

@export var min_speed: float
@export var max_speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_random_speed() -> float:
	return randf_range(min_speed, max_speed)

func set_starting_speed(distance_vector: Vector2) -> void:
	speed = get_random_speed() * distance_vector

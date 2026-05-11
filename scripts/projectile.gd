class_name Projectile
extends GraphicalObject

@export var initial_speed: int
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var turn: bool = false

func set_starting_speed(distance_vector: Vector2) -> void:
	speed = initial_speed * distance_vector

func turn_towards_direction():
	self.look_at(self.global_position + speed)

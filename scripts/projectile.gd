class_name Projectile
extends GraphicalObject

@export var initial_speed: int
@export var weapon_type: GlobalEnums.Weapon
var turn: bool = false

func set_starting_speed(distance_vector: Vector2) -> void:
	speed = initial_speed * distance_vector

func turn_towards_direction():
	self.look_at(self.global_position + speed)

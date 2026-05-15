class_name Enemy
extends GraphicalObject

signal enemy_defeated(enemies_hit: int, score: int)

@export var points_worth: float

@export var min_speed: float
@export var max_speed: float
var defeated: bool = false
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gravity_component: Node = $GravityComponent


func get_random_speed() -> float:
	return randf_range(min_speed, max_speed)

func set_starting_speed(distance_vector: Vector2) -> void:
	speed = get_random_speed() * distance_vector

func _on_area_entered(area: Area2D) -> void:
	if !defeated && area.is_in_group("projectiles"):
		self.defeated = true
		sprite_2d.flip_v = true
		if area is Lightning:
			speed = Vector2(0,0)
		else:
			speed = area.speed / 2
		gravity_component.gravity_force = 200
		area.enemies_hit += 1
		area.impact_on_enemy(self)
		self.enemy_defeated.emit(area.enemies_hit, points_worth)
		if area is Boom:
			queue_free()

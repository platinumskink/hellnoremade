class_name Skyver
extends Enemy

@export var rocket_speed: int = 800
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d_2.visible = false
	collision_shape_2d_2.disabled = true

func _on_timer_timeout() -> void:
	if !defeated:
		gravity_component.gravity_force = 0
		sprite_2d.visible = false
		collision_shape_2d.disabled = true
		sprite_2d_2.visible = true
		sprite_2d.visible = false
		collision_shape_2d_2.disabled = false
		speed = Vector2(0, -rocket_speed)

func _on_enemy_defeated(enemies_hit: int, score: int) -> void:
	sprite_2d_2.flip_v = true

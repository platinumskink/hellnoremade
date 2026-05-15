class_name Arrow
extends Projectile

@export var _rotation_speed: float
@onready var arrow_sprite_2d: Sprite2D = $Sprite2D
@onready var arrow_shape_2d: CollisionShape2D = $CollisionShape2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	var mouse_point: Vector2 = get_global_mouse_position()
	var direction: Vector2 = position.direction_to(mouse_point)
	self.rotation = rotate_toward(self.rotation, direction.angle(), _rotation_speed * delta)
	speed = Vector2(initial_speed,0).rotated(self.rotation)

func _on_timer_timeout() -> void:
	queue_free()

func impact_on_enemy(_enemy: Enemy) -> void:
	pass

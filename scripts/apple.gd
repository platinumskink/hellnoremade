class_name Apple
extends Projectile

func impact_on_enemy(_area: Area2D) -> void:
	speed.y = -600
	speed.x /= 2

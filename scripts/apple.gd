class_name Apple
extends Projectile

func impact_on_enemy(area: Area2D) -> void:
	speed.y = -600
	speed.x /= 2
	enemies_hit += 1

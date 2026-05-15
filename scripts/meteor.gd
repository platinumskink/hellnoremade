class_name Meteorite
extends Projectile

func impact_on_enemy(enemy: Enemy) -> void:
	enemy.speed *= 5

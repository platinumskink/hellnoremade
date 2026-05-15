class_name Lightning
extends Projectile


func impact_on_enemy(enemy: Enemy) -> void:
	if enemy.defeated:
		enemy.sprite_2d.modulate = Color(0,0,0)
		if enemy is Skyver:
			enemy.sprite_2d_2.modulate = Color(0,0,0)

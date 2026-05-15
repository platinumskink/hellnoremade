class_name RainDrop
extends Projectile

func impact_on_enemy(_enemy: Enemy) -> void:
	self.queue_free()

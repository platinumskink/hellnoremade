class_name RainDrop
extends Projectile

func impact_on_enemy(_enemy: Area2D) -> void:
	self.queue_free()

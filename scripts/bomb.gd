class_name Bomb
extends Projectile

var boom: Resource = preload("res://scenes/weapons/boom.tscn")


func impact_on_enemy(_enemy: Area2D) -> void:
	var instance: Boom = boom.instantiate()
	instance.enemies_hit = enemies_hit
	instance.position = self.position
	var parent: ProjectileFactory = get_parent()
	parent.add_child(instance)
	queue_free()

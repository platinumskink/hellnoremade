class_name Boom
extends Projectile

func impact_on_enemy(_enemy: Enemy) -> void:
	print("boom impact!")
	pass


func _on_timer_timeout() -> void:
	queue_free()

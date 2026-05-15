class_name GameZone
extends Area2D

func _on_area_exited(area: Area2D) -> void:
	if area is Projectile && area is not Arrow:
		area.queue_free()
	if area is Enemy && !area.defeated:
		if area.global_position.x < 0 && area.speed.x < 0:
			area.speed.x *= -1
		if area.global_position.x > 0 && area.speed.x > 0:
			area.speed.x *= -1

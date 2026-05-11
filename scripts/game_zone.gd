class_name GameZone
extends Area2D

func _on_area_exited(area: Area2D) -> void:
	if area is Projectile:
		print("deleted")
		area.queue_free()

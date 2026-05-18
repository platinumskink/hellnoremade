extends Area2D

signal enemy_escaped(location: Vector2)

func _on_area_entered(area: Area2D) -> void:
	if area is Rain:
		area.queue_free()
	if area is Enemy && !area.defeated:
		area.queue_free()
		enemy_escaped.emit(area.position)

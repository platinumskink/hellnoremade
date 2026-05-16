extends Area2D



func _on_area_entered(area: Area2D) -> void:
	if area is Blob:
		area.enemy_defeated.emit(area.latest_enemies_hit, area.points_worth)
		area.queue_free()

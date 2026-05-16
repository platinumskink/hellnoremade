class_name Blob
extends Enemy

var hit_projectiles: Array[Projectile]
var latest_enemies_hit: int = 0

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		if area in hit_projectiles:
			return
		if area is Boom:
			enemy_defeated.emit(area.enemies_hit, points_worth)
			queue_free()
			return
		speed += area.speed / 500
		if area is Apple || area is Lightning:
			speed += area.speed / 10
		if area is Meteorite || area is Arrow:
			speed += area.speed / 5
			area.speed.y = -200
		area.enemies_hit += 1
		area.impact_on_enemy(self)
		if area is Lightning:
			area.queue_free()
		latest_enemies_hit = area.enemies_hit

		hit_projectiles.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area in hit_projectiles:
		hit_projectiles.erase(area)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	speed.x *= 0.98 * delta

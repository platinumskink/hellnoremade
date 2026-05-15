class_name Blob
extends Enemy

var hit_projectiles: Array[Projectile]

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		if area in hit_projectiles:
			return
		speed += area.speed / 50
		if area is Apple || area is Lightning:
			speed += area.speed / 5
		if area is Meteorite:
			speed += area.speed / 3
			area.speed.y = -200
		area.enemies_hit += 1
		area.impact_on_enemy(self)
		if area is Lightning:
			area.queue_free()

		hit_projectiles.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area in hit_projectiles:
		hit_projectiles.erase(area)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	speed.x *= 0.98 * delta

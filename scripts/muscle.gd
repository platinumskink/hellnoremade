class_name Muscle
extends Enemy

var lives: int = 30

var hit_projectiles: Array[Projectile]
@onready var timer: Timer = $Timer

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		if area is Meteorite || area is Boom:
			lives = 0
		if area in hit_projectiles:
			return
		hit_projectiles.append(area)
		sprite_2d.modulate = Color(1,0,0)
		timer.start(0)
		if area is Lightning || area is Arrow:
			lives -= 8
		if area is Apple:
			lives -= 3
		if area is RainDrop:
			lives -= 1
		if lives <= 0:
			super._on_area_entered(area)
		else:
			area.enemies_hit += 1
			area.impact_on_enemy(self)
		if area is Lightning:
			area.queue_free()
		if area is Meteorite:
			area.speed.y = -300

func _on_area_exited(area: Area2D) -> void:
	if area in hit_projectiles:
		hit_projectiles.erase(area)

func _on_timer_timeout() -> void:
	if !defeated:
		sprite_2d.modulate = Color(1,1,1)

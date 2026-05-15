extends Enemy

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gravity_component: Node = $GravityComponent


func _on_area_entered(area: Area2D) -> void:
	if !defeated && area.is_in_group("projectiles"):
		print("demon hit")
		self.defeated = true
		sprite_2d.flip_v = true
		speed = area.speed
		gravity_component.gravity_force = 200
		area.impact_on_enemy(self)
		self.enemy_defeated.emit(area.enemies_hit, points_worth)

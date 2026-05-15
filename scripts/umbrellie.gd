class_name Umbrellie
extends Enemy

@onready var umbrella: Umbrella = $Umbrella

func _on_enemy_defeated(enemies_hit: int, score: int) -> void:
	var parent: EnemyFactory = get_parent()
	remove_child(umbrella)
	parent.add_child(umbrella)
	var random_number: float = randf_range(-100, 100)
	umbrella.speed.y -= 50
	umbrella.speed.x = random_number
	umbrella.global_position = global_position
	umbrella.position.y -= 25
	umbrella.position.x -= 2
	umbrella.gravity_component.gravity_force = -100

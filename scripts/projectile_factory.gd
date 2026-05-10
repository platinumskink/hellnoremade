class_name ProjectileFactory
extends Node

var apple = preload("res://scenes/apple.tscn")

func shoot(start_point: Vector2, speed: Vector2, wpn: GlobalEnums.Weapon):
	match wpn:
		GlobalEnums.Weapon.APPLE:
			var instance := apple.instantiate()
			instance.position = start_point
			add_child(instance)

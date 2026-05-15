class_name ProjectileFactory
extends Node

var apple: Resource = preload("res://scenes/weapons/apple.tscn")
var lightning: Resource = preload("res://scenes/weapons/lightning.tscn")
var meteor: Resource = preload("res://scenes/weapons/meteor.tscn")
var rain: Resource = preload("res://scenes/weapons/rain.tscn")
var arrow: Resource = preload("res://scenes/weapons/arrow.tscn")
var bomb: Resource = preload("res://scenes/weapons/bomb.tscn")


@export var gameZone: GameZone

func shoot(start_point: Vector2, distance_vector: Vector2, wpn: GlobalEnums.Weapon) -> void:
	var instance
	match wpn:
		GlobalEnums.Weapon.APPLE:
			instance = apple.instantiate()
			instance.set_starting_speed(distance_vector)
		GlobalEnums.Weapon.LIGHTNING:
			instance = lightning.instantiate()
			instance.set_starting_speed(distance_vector)
			instance.turn_towards_direction()
		GlobalEnums.Weapon.METEORITE:
			instance = meteor.instantiate()
			instance.set_starting_speed(distance_vector)
			instance.turn = true
		GlobalEnums.Weapon.RAIN:
			instance = rain.instantiate()
			instance.set_starting_speed(distance_vector)
		GlobalEnums.Weapon.BOW:
			instance = arrow.instantiate()
			instance.set_starting_speed(distance_vector)
			instance.turn_towards_direction()
		GlobalEnums.Weapon.BOMB:
			instance = bomb.instantiate()
			instance.set_starting_speed(distance_vector)

			
	instance.position = start_point
	add_child(instance)
	if wpn == GlobalEnums.Weapon.RAIN:
		instance.reset_timers()

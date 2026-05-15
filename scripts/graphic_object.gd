class_name GraphicalObject
extends Area2D

var speed:Vector2 = Vector2(0,0)
var turn: bool = false

func _physics_process(delta: float) -> void:
	position += delta * speed

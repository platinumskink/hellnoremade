class_name Debat
extends Enemy

var spin_speed: float = 500
var switch_speed: float = 200

var default_speed: Vector2
var extra_speed: Vector2 = Vector2(0,0)

var up: bool = true
var right: bool = true

func set_default_speed() -> void:
	default_speed = speed
	var random: int = randi_range(0,1)
	if random == 0:
		speed.x = switch_speed
	else:
		speed.x = -switch_speed

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if defeated:
		return
	if up:
		speed.y -= spin_speed * delta
	else:
		speed.y += spin_speed * delta
	if right:
		speed.x += spin_speed * delta
	else:
		speed.x -= spin_speed * delta
	if up && speed.y < default_speed.y - switch_speed:
		up = false
	if !up && speed.y > default_speed.y + switch_speed:
		up = true
	if right && speed.x > default_speed.x + switch_speed:
		right = false
	if !right && speed.x < default_speed.x - switch_speed:
		right = true

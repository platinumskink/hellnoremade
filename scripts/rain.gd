class_name Rain
extends Projectile

@export_range(0.1, 2.0, 0.1) var time_range_min: float
@export_range(0.1, 2.0, 0.1) var time_range_max: float
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var timer_3: Timer = $Timer3
@onready var cloud_length: CollisionShape2D = $CollisionShape2D

var rainDrop = preload("res://scenes/weapons/rain_drop.tscn")

func reset_timers():
	reset_timer()
	reset_timer_2()
	reset_timer_3()

func reset_timer():
	var new_time: float = randf_range(time_range_min, time_range_max)
	print(new_time)
	timer.wait_time = new_time
	timer.start(0)

func reset_timer_2():
	var new_time: float = randf_range(time_range_min, time_range_max)
	print(new_time)
	timer_2.wait_time = new_time
	timer_2.start(0)

func reset_timer_3():
	var new_time: float = randf_range(time_range_min, time_range_max)
	print(new_time)
	timer_3.wait_time = new_time
	timer_3.start(0)

func _on_timer_timeout() -> void:
	reset_timer()
	spawn_raindrop()
	
func _on_timer_2_timeout() -> void:
	reset_timer_2()
	spawn_raindrop()

func _on_timer_3_timeout() -> void:
	reset_timer_3()
	spawn_raindrop()
	
func spawn_raindrop() -> void:
	var instance = rainDrop.instantiate()
	instance.set_starting_speed(Vector2(0, 1))
	var rect : Rect2 = cloud_length.shape.get_rect()
	var x = randi_range(rect.position.x, rect.position.x+rect.size.x)
	var rand_point = Vector2(x,0) 
	instance.z_index -= 1
	instance.position = rand_point + global_position
	get_parent().add_child(instance)

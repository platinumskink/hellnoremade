extends Area2D

var appearance_rate = [1, 0, 0, 0, 0, 0]
var demon_type = [
	GlobalEnums.Demons.DEMON,
	GlobalEnums.Demons.DEBAT,
	GlobalEnums.Demons.UMBRELLIE,
	GlobalEnums.Demons.SKYVER,
	GlobalEnums.Demons.MUSCLE,
	GlobalEnums.Demons.BLOB,
]
var appearance_percent_chance = 5
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var enemy_count: int = 0

var demon = preload("res://scenes/enemies/demon.tscn")




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	timer.start(0)
	var roll: int = randf_range(0, 100)
	if roll <= appearance_percent_chance:
		enemy_count += 1
		spawn_enemy()
		roll = randf_range(0, 100)

func spawn_enemy():
	var enemy_type = pick_enemy_type()
	var rect : Rect2 = collision_shape_2d.shape.get_rect()
	var x = randi_range(rect.position.x, rect.position.x+rect.size.x) + (rect.size.x / 2)
	var rand_point = Vector2(x,0) 
	var instance
	match enemy_type:
		GlobalEnums.Demons.DEMON:
			instance = demon.instantiate()
			instance.set_starting_speed(Vector2(0, -1))
		GlobalEnums.Demons.DEBAT:
			return
		GlobalEnums.Demons.UMBRELLIE:
			return
		GlobalEnums.Demons.SKYVER:
			return
		GlobalEnums.Demons.MUSCLE:
			return
		GlobalEnums.Demons.BLOB:
			return
	instance.position = rand_point
	add_child(instance)

func pick_enemy_type() -> GlobalEnums.Demons:
	var totalCount: int = 0
	for rate in appearance_rate:
		totalCount += rate
	var randomNumber: int = randi_range(0, totalCount)
	for i in appearance_rate.size():
		randomNumber -= appearance_rate[i]
		if randomNumber <= 0:
			return demon_type[i]
	assert(randomNumber <= 0, "pick_enemy_type failed")
	return GlobalEnums.Demons.DEMON

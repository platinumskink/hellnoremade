class_name EnemyFactory
extends Area2D

signal add_to_score(score: int)

var appearance_rate: Array[int] = [0, 0, 0, 1, 0, 0]
var demon_type: Array[GlobalEnums.Demons] = [
	GlobalEnums.Demons.DEMON,
	GlobalEnums.Demons.DEBAT,
	GlobalEnums.Demons.UMBRELLIE,
	GlobalEnums.Demons.SKYVER,
	GlobalEnums.Demons.MUSCLE,
	GlobalEnums.Demons.BLOB,
]
var appearance_percent_chance: int = 5
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var enemy_count: int = 0

var demon: Resource = preload("res://scenes/enemies/demon.tscn")
var debat: Resource = preload("res://scenes/enemies/debat.tscn")
var umbrellie: Resource = preload("res://scenes/enemies/umbrellie.tscn")
var skyver: Resource = preload("res://scenes/enemies/skyver.tscn")


func _on_timer_timeout() -> void:
	timer.start(0)
	var roll: float = randf_range(0, 100)
	if roll <= appearance_percent_chance:
		enemy_count += 1
		spawn_enemy()
		roll = randf_range(0, 100)

func spawn_enemy() -> void:
	var enemy_type: GlobalEnums.Demons = pick_enemy_type()
	print("picked enemy type: " + str(enemy_type))
	var rect : Rect2 = collision_shape_2d.shape.get_rect()
	var x: float = randi_range(rect.position.x, rect.position.x+rect.size.x) + (rect.size.x / 2)
	var rand_point: Vector2 = Vector2(x,0) 
	var instance: GraphicalObject
	match enemy_type:
		GlobalEnums.Demons.DEMON:
			instance = demon.instantiate()
			instance.set_starting_speed(Vector2(0, -1))
		GlobalEnums.Demons.DEBAT:
			instance = debat.instantiate()
			instance.set_starting_speed(Vector2(0, -1))
			instance.set_default_speed()
		GlobalEnums.Demons.UMBRELLIE:
			instance = umbrellie.instantiate()
			instance.set_starting_speed(Vector2(0, -1))
		GlobalEnums.Demons.SKYVER:
			instance = skyver.instantiate()
			var skyver_x: int = 50
			if rand_point.x > (DisplayServer.window_get_size().x / 2):
				skyver_x *= -1
			instance.set_starting_speed(Vector2(skyver_x, -100).normalized())
		GlobalEnums.Demons.MUSCLE:
			return
		GlobalEnums.Demons.BLOB:
			return
	instance.position = rand_point
	add_child(instance)
	instance.connect("enemy_defeated", self.enemy_defeated)

func pick_enemy_type() -> GlobalEnums.Demons:
	var totalCount: int = 0
	for rate in appearance_rate:
		totalCount += rate
	var randomNumber: int = randi_range(0, totalCount)
	for i in appearance_rate.size():
		if appearance_rate[i] == 0:
			continue
		randomNumber -= appearance_rate[i]
		if randomNumber <= 0:
			return demon_type[i]
	assert(randomNumber <= 0, "pick_enemy_type failed")
	return GlobalEnums.Demons.DEMON

func enemy_defeated(enemies_hit: int, score: int) -> void:
	var score_added: int = enemies_hit * score
	print("worth: " + str(score_added))
	add_to_score.emit(score_added)

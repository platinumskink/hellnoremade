class_name EnemyFactory
extends Area2D

signal add_to_score(score: int)
var seconds_per_stage: int = 30
var speed_multiplier: int = 1

var appearance_rate = [
	[1, 0, 0, 0, 0, 0],
	[2, 1, 0, 0, 0, 0],
	[4, 2, 1, 0, 0, 0],
	[2, 1, 4, 0, 0, 0],
	[2, 4, 2, 0, 0, 0],
	[5, 0, 0, 1, 0, 0],
	[8, 4, 2, 1, 0, 0],
	[1, 1, 5, 2, 0, 0],
	[1, 4, 1, 1, 0, 0],
	[4, 0, 0, 0, 4, 0],
	[2, 2, 2, 1, 2, 0],
	[0, 1, 0, 0, 0, 0],
	[1, 1, 1, 0, 1, 1],
	[5, 4, 3, 0, 2, 1],
	[5, 0, 0, 5, 0, 0],
	[0, 0, 5, 0, 0, 5],
	[3, 3, 4, 0, 5, 6],
	[1, 1, 1, 1, 1, 1],
	[1, 6, 1, 1, 1, 6],
	[0, 0, 0, 0, 1, 0],
	[0, 0, 1, 0, 0, 0],
	[0, 0, 0, 1, 0, 0],
	[0, 0, 0, 0, 0, 1],
	[16, 12, 8, 4, 2, 1],
	[1, 1, 1, 1, 1, 1],
	]
var current_appearence_rate: int = 0

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
@onready var make_things_harder_timer: Timer = $MakeThingsHarderTimer

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var enemy_count: int = 0

var demon: Resource = preload("res://scenes/enemies/demon.tscn")
var debat: Resource = preload("res://scenes/enemies/debat.tscn")
var umbrellie: Resource = preload("res://scenes/enemies/umbrellie.tscn")
var skyver: Resource = preload("res://scenes/enemies/skyver.tscn")
var muscle: Resource = preload("res://scenes/enemies/muscle.tscn")
var blob: Resource = preload("res://scenes/enemies/blob.tscn")


func _on_timer_timeout() -> void:
	timer.start(0)
	var roll: float = randf_range(0, 100)
	if roll <= appearance_percent_chance:
		enemy_count += 1
		spawn_enemy()
		roll = randf_range(0, 100)

func spawn_enemy() -> void:
	var enemy_type: GlobalEnums.Demons = pick_enemy_type()
	#print("picked enemy type: " + str(enemy_type))
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
			instance = muscle.instantiate()
			instance.set_starting_speed(Vector2(0, -1))
		GlobalEnums.Demons.BLOB:
			instance = blob.instantiate()
			instance.set_starting_speed(Vector2(0, -1))
			rand_point.y += 50
	instance.position = rand_point
	instance.speed.y *= speed_multiplier
	add_child(instance)
	instance.connect("enemy_defeated", self.enemy_defeated)

func pick_enemy_type() -> GlobalEnums.Demons:
	var totalCount: int = 0
	for rate in appearance_rate[current_appearence_rate]:
		totalCount += rate
	var randomNumber: int = randi_range(0, totalCount)
	for i in appearance_rate[current_appearence_rate].size():
		if appearance_rate[current_appearence_rate][i] == 0:
			continue
		randomNumber -= appearance_rate[current_appearence_rate][i]
		if randomNumber <= 0:
			return demon_type[i]
	assert(randomNumber <= 0, "pick_enemy_type failed")
	return GlobalEnums.Demons.DEMON

func enemy_defeated(enemies_hit: int, score: int) -> void:
	var score_added: int = enemies_hit * score
	#print("worth: " + str(score_added))
	add_to_score.emit(score_added)

func _on_make_things_harder_timer_timeout() -> void:
	print("making things harder")
	if current_appearence_rate < appearance_rate.size():
		current_appearence_rate += 1
	else:
		current_appearence_rate = 0
		speed_multiplier += 1
	make_things_harder_timer.start(0)

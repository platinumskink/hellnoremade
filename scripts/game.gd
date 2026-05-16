extends Node2D


var lives: int = 20
var score: int = 0
@onready var life_tracker: Label = $LifeTracker
@onready var score_tracker: Label = $ScoreTracker
@onready var inventory: Node2D = $Inventory
@onready var pause_menu: Node = $PauseMenu
@onready var pause_timer: Timer = $PauseTimer
@onready var god: Node2D = $God

var new_weapons_every: int = 500
var points_since_last_refill: int = 0
var got_bomb: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	life_tracker.text = "Lives: " + str(lives)
	score_tracker.text = "Score: " + str(score)

func _on_god_throw(wpn: GlobalEnums.Weapon, weapon_ammo: int) -> void:
	inventory.update_inventory(wpn, weapon_ammo)

func _on_god_changed_weapon(wpn: GlobalEnums.Weapon) -> void:
	inventory.set_current_weapon(wpn)

func _on_top_zone_enemy_escaped() -> void:
	lives -= 1
	life_tracker.text = "Lives: " + str(lives)
	if lives <= 0:
		Globals.final_score = score
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func _on_enemy_factory_add_to_score(enemy_score: int) -> void:
	score += enemy_score
	points_since_last_refill += enemy_score
	score_tracker.text = "Score: " + str(score)
	if points_since_last_refill >= new_weapons_every:
		points_since_last_refill -= new_weapons_every
		god.add_ammo()

var cant_pause: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if !cant_pause:
			if !get_tree().paused:
				pause_menu.visible = true
				pause_menu.pause_layer.visible = true
				cant_pause = true
				pause_timer.start(0)
				get_tree().paused = true


func _on_pause_timer_timeout() -> void:
	cant_pause = false


func _on_button_button_down() -> void:
	if !cant_pause:
			if !get_tree().paused:
				print("game paused")
				pause_menu.visible = true
				pause_menu.pause_layer.visible = true
				cant_pause = true
				pause_timer.start(0)
				get_tree().paused = true


func _on_god_update_all_ammo(weapon_ammo: Dictionary[GlobalEnums.Weapon, int]) -> void:
	inventory.update_inventory(GlobalEnums.Weapon.LIGHTNING, weapon_ammo[GlobalEnums.Weapon.LIGHTNING])
	inventory.update_inventory(GlobalEnums.Weapon.METEORITE, weapon_ammo[GlobalEnums.Weapon.METEORITE])
	inventory.update_inventory(GlobalEnums.Weapon.RAIN, weapon_ammo[GlobalEnums.Weapon.RAIN])
	inventory.update_inventory(GlobalEnums.Weapon.BOW, weapon_ammo[GlobalEnums.Weapon.BOW])
	inventory.update_inventory(GlobalEnums.Weapon.BOMB, weapon_ammo[GlobalEnums.Weapon.BOMB])
	

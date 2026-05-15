extends Node2D


var lives: int = 100
var score: int = 0
@onready var life_tracker: Label = $LifeTracker
@onready var score_tracker: Label = $ScoreTracker
@onready var inventory: Node2D = $Inventory

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
		get_tree().quit()


func _on_enemy_factory_add_to_score(enemy_score: int) -> void:
	score += enemy_score
	score_tracker.text = "Score: " + str(score)

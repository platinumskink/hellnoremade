extends Node2D


var lives: int = 5
@onready var life_tracker: Label = $LifeTracker
@onready var inventory: Node2D = $Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_god_throw(wpn: GlobalEnums.Weapon, weapon_ammo: int) -> void:
	inventory.update_inventory(wpn, weapon_ammo)

func _on_god_changed_weapon(wpn: GlobalEnums.Weapon) -> void:
	inventory.set_current_weapon(wpn)


func _on_top_zone_enemy_escaped() -> void:
	lives -= 1
	life_tracker.text = str(lives)
	if lives <= 0:
		get_tree().quit()

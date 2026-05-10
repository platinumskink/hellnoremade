extends Node2D


@onready var inventory: Node2D = $Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_god_throw() -> void:
	print("Game is receiving god's throw.")


func _on_god_changed_weapon(wpn: GlobalEnums.Weapon) -> void:
	inventory.set_current_weapon(wpn)

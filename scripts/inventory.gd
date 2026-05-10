extends Node2D

@onready var selection: Sprite2D = $Sprite2D/Selection

var weapon_x_values: Dictionary[GlobalEnums.Weapon, int] = {}
		

# Y = 
var AppleX    : int = -127
var LightningX: int = -98
var MeteoriteX: int = -53
var RainX     : int = 15
var BowX      : int = 83
var BombX     : int = 125

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon_x_values = {
		GlobalEnums.Weapon.APPLE: AppleX,
		GlobalEnums.Weapon.LIGHTNING: LightningX,
		GlobalEnums.Weapon.METEORITE: MeteoriteX,
		GlobalEnums.Weapon.RAIN: RainX,
		GlobalEnums.Weapon.BOW: BowX,
		GlobalEnums.Weapon.BOMB: BombX,
	}
	selection.position.x = weapon_x_values[GlobalEnums.Weapon.APPLE]


func set_current_weapon(wpn: GlobalEnums.Weapon):
	selection.position.x = weapon_x_values[wpn]

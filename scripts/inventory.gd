extends Node2D

@onready var selection: Sprite2D = $Sprite2D/Selection
@onready var lightning_label: Label = $LightningLabel
@onready var meteor_label: Label = $MeteorLabel
@onready var rain_label: Label = $RainLabel
@onready var bow_label: Label = $BowLabel
@onready var bomb_label: Label = $BombLabel


var weapon_x_values: Dictionary[GlobalEnums.Weapon, int] = {}
var weapon_ammo_label_dictionary: Dictionary[GlobalEnums.Weapon, Label] = {}


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
	weapon_ammo_label_dictionary = {
		GlobalEnums.Weapon.LIGHTNING: lightning_label,
		GlobalEnums.Weapon.METEORITE: meteor_label,
		GlobalEnums.Weapon.RAIN: rain_label,
		GlobalEnums.Weapon.BOW: bow_label,
		GlobalEnums.Weapon.BOMB: bomb_label,
  	}
	selection.position.x = weapon_x_values[GlobalEnums.Weapon.APPLE]


func set_current_weapon(wpn: GlobalEnums.Weapon) -> void:
	selection.position.x = weapon_x_values[wpn]

func update_inventory(wpn: GlobalEnums.Weapon, ammo: int) -> void:
	if wpn != GlobalEnums.Weapon.APPLE:
		var label: Label = weapon_ammo_label_dictionary[wpn]
		label.text = str(ammo)

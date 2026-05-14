extends Node2D

@onready var god: Sprite2D = $God
@onready var arm: Sprite2D = $Arm
@onready var timer: Timer = $Timer
@onready var arrow: Sprite2D = $Arrow
@onready var weapon: Sprite2D = $God/Weapon

@export var projectile_factory: ProjectileFactory

const apple: Texture2D = preload("res://assets/Apple.png")
const lightning: Texture2D = preload("res://assets/Bolt.png")
const meteor: Texture2D = preload("res://assets/CometInHand.png")
const rain: Texture2D = preload("res://assets/Cloud.png")
const bow_drawn: Texture2D = preload("res://assets/BowHeld.png")
const bow_fired: Texture2D = preload("res://assets/BowLaunched.png")
const bomb: Texture2D = preload("res://assets/Bomb.png")

signal throw(ammo: int)
signal changed_weapon(wpn: GlobalEnums.Weapon)

var weapon_sprites: Dictionary[GlobalEnums.Weapon, Texture2D] = {
	GlobalEnums.Weapon.APPLE: apple,
	GlobalEnums.Weapon.LIGHTNING: lightning,
	GlobalEnums.Weapon.METEORITE: meteor,
	GlobalEnums.Weapon.RAIN: rain,
	GlobalEnums.Weapon.BOW: bow_drawn,
	GlobalEnums.Weapon.BOMB: bomb,
}
var weapon_in_hand_offsets: Dictionary[GlobalEnums.Weapon, Vector2] = {
	GlobalEnums.Weapon.APPLE: Vector2(22, -13),
	GlobalEnums.Weapon.LIGHTNING: Vector2(22, -13),
	GlobalEnums.Weapon.METEORITE: Vector2(40, -13),
	GlobalEnums.Weapon.RAIN: Vector2(90, -13),
	GlobalEnums.Weapon.BOW: Vector2(0,0),
	GlobalEnums.Weapon.BOMB: Vector2(22,-13),
}
var weapon_ammo: Dictionary[GlobalEnums.Weapon, int] = {
	GlobalEnums.Weapon.APPLE: 1,
	GlobalEnums.Weapon.LIGHTNING: 10,
	GlobalEnums.Weapon.METEORITE: 10,
	GlobalEnums.Weapon.RAIN: 10,
	GlobalEnums.Weapon.BOW: 10,
	GlobalEnums.Weapon.BOMB: 10,
}

var throwDelay: float = 0.5
var canThrow: bool = true
var hasThrown: bool = false
var originalRotation: float = 0.0

var currentWeapon: GlobalEnums.Weapon = GlobalEnums.Weapon.APPLE:
	set(value):
		currentWeapon = value
		changed_weapon.emit(value)
		weapon.texture = weapon_sprites[value]
		weapon.position = weapon_in_hand_offsets[value]
		if value != GlobalEnums.Weapon.BOW:
			weapon.rotation = 0
			arm.visible = true
		else:
			arm.visible = false
		if value == GlobalEnums.Weapon.LIGHTNING:
			weapon.rotation_degrees = 90

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = throwDelay
	originalRotation = arm.rotation


func _physics_process(delta: float) -> void:
	arrow.look_at(get_global_mouse_position())
	if !canThrow && !hasThrown:
		arm.look_at(get_global_mouse_position())
		hasThrown = true
	if currentWeapon == GlobalEnums.Weapon.BOW:
		weapon.visible = true
		weapon.look_at(get_global_mouse_position())
		if hasThrown || weapon_ammo[currentWeapon] <= 0:
			weapon.texture = bow_fired
		else:
			weapon.texture = bow_drawn
	else:
		if hasThrown || weapon_ammo[currentWeapon] <= 0:
			weapon.visible = false
		else:
			weapon.visible = true

func _input(event): # When an action happened.
	if event.is_action_pressed("click") && canThrow:
		canThrow = false
		timer.start(throwDelay)
		if weapon_ammo[currentWeapon] > 0:
			if currentWeapon != GlobalEnums.Weapon.APPLE:
				weapon_ammo[currentWeapon] -= 1
			throw.emit(currentWeapon, weapon_ammo[currentWeapon])
			var distance_vector: Vector2 = get_global_mouse_position() - global_position
			projectile_factory.shoot(god.global_position, distance_vector.normalized(), currentWeapon)
		
	if event.is_action_pressed("weapon1"):
		currentWeapon = GlobalEnums.Weapon.APPLE
	if event.is_action_pressed("weapon2"):
		currentWeapon = GlobalEnums.Weapon.LIGHTNING
	if event.is_action_pressed("weapon3"):
		currentWeapon = GlobalEnums.Weapon.METEORITE
	if event.is_action_pressed("weapon4"):
		currentWeapon = GlobalEnums.Weapon.RAIN
	if event.is_action_pressed("weapon5"):
		currentWeapon = GlobalEnums.Weapon.BOW
	if event.is_action_pressed("weapon6"):
		currentWeapon = GlobalEnums.Weapon.BOMB
	if event.is_action_pressed("nextWeapon"):
		var newWeapon:int = currentWeapon + 1
		if newWeapon > 5:
			currentWeapon = 0
		else:
			currentWeapon = newWeapon
	if event.is_action_pressed("previousWeapon"):
		var newWeapon:int = currentWeapon - 1
		if newWeapon < 0:
			currentWeapon = 5
		else:
			currentWeapon = newWeapon

func _on_timer_timeout() -> void:
	canThrow = true
	hasThrown = false
	arm.rotation = originalRotation

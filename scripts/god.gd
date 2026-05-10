extends Node2D

@onready var arm: Sprite2D = $Arm
@onready var timer: Timer = $Timer
@onready var arrow: Sprite2D = $Arrow

signal throw

var throwDelay: float = 0.5
var canThrow: bool = true
var hasThrown: bool = false
var originalRotation: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = throwDelay
	originalRotation = arm.rotation


func _physics_process(delta: float) -> void:
	arrow.look_at(get_global_mouse_position())
	if !canThrow && !hasThrown:
		arm.look_at(get_global_mouse_position())
		hasThrown = true
	
func _input(event): # When an action happened.
	if event.is_action_pressed("click") && canThrow:
		canThrow = false
		timer.start(throwDelay)
		throw.emit()

func _on_timer_timeout() -> void:
	canThrow = true
	hasThrown = false
	arm.rotation = originalRotation

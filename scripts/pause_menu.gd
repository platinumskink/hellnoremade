extends Node

@onready var pause_layer: CanvasLayer = $PauseLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		unpause()

func unpause() -> void:
	get_tree().paused = false
	pause_layer.visible = false
	self.visible = false

func _on_unpause_button_pressed() -> void:
	unpause()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)

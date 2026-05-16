extends Node2D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Final Score: " + str(Globals.final_score)


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

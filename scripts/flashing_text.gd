class_name FlashingText
extends Label

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play_flash():
	animation_player.play("flashing_text")

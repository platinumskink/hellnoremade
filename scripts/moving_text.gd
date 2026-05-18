extends Label

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func move_text():
	animation_player.play("MovingText")

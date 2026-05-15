class_name Umbrella
extends GraphicalObject

@onready var gravity_component: Node = $GravityComponent
var interactable: bool = true

func _on_area_entered(area: Area2D) -> void:
	if interactable:
		if area is Apple || area is RainDrop || area is Bomb:
			area.impact_on_enemy(self)

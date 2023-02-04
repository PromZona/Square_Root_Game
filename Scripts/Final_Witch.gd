extends Area2D

onready var math: Sprite = $"../ENDING_MATH"
onready var witch: Sprite = $"../ENDING_WITCH"

func _process(delta):
	if (witch.visible or math.visible):
		return
	var bodies: Array = get_overlapping_bodies()
	if bodies.size() > 0:
		witch.show()


extends Position2D

onready var player: Player = $"../Charachter" as Player

func _process(delta):
	position = player.position

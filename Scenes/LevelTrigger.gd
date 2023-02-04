extends Area2D

onready var witch: Enemy = $"../Witch"

var activated: bool = false

func _on_LevelTrigger_body_entered(body):
	if activated:
		return
	
	if body is Player:
		if not witch.IsActive:
			witch.IsActive = true
			body.spawn_point = self
			body.enemy = witch
			activated = true

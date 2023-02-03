extends Node2D


func _on_ClickPlace_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		var bodies = $EnemyPlace.get_overlapping_bodies()
		for body in bodies:
			body = body as KinematicBody2D
			body.receive_damage(2)

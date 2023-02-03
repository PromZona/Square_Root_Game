extends Area2D

onready var cone: CollisionPolygon2D = $Cone

func push_all(current_pos: Vector2):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		var kinem: KinematicBody2D = body as KinematicBody2D
		var velocity: Vector2 = (kinem.position - current_pos) * 10;
		kinem.move_and_slide(velocity)
	
func _input(event):
	event = event as InputEventMouseMotion
	if event == null:
		return
	look_at(get_global_mouse_position())
	

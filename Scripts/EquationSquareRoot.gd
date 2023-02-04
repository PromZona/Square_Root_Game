extends Node2D

func _on_ClickPlace_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 2 and event.is_pressed():
		var bodies = $EnemyPlace.get_overlapping_bodies()
		for body in bodies:
			if (body is Player) or (body is Enemy):
				body.square()

var mouse_inside: bool = false
var modul: float = 1.0

func _on_ClickPlace_mouse_entered():
	mouse_inside = true
	

func _on_ClickPlace_mouse_exited():
	mouse_inside = false
	$Sprite.modulate = Color(1, 1, 1)

func _process(delta):
	if not mouse_inside:
		return
	modul += delta * 4
	var res: float = clamp(sin(modul), 0.5, 1.0) 
	$Sprite.modulate = Color(res, res, res)

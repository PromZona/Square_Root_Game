extends Node2D

export var heal: int = 1

func _on_ClickArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 2 and event.is_pressed():
		var bodies = $EnemyArea.get_overlapping_bodies()
		for body in bodies:
			if (body is Player) or (body is Enemy):
				body.heal(heal)

var mouse_inside: bool = false
var modul: float = 1.0

func _on_ClickArea_mouse_entered():
	mouse_inside = true

func _on_ClickArea_mouse_exited():
	mouse_inside = false
	$Sprite.modulate = Color(1, 1, 1)
	
func _process(delta):
	if not mouse_inside:
		return
	modul += delta * 4
	var res: float = clamp(sin(modul), 0.5, 1.0) 
	$Sprite.modulate = Color(res, res, res)


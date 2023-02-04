extends Node2D

func _ready():
	# get_tree().debug_collisions_hint = true
	# get_tree().debug_collisions_hint = true
	pass

func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()


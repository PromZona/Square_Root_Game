extends StaticBody2D

export var open_on_start: bool = true
export var door_level: int = 1

func _ready():
	if open_on_start:
		open()
	else:
		close()

func open():
	$Door.disabled = true
	visible = false

func close():
	$Door.disabled = false
	visible = true


func _on_Dummy_Witch_open_door(level):
	if (door_level == level):
		open()


func _on_EasyWitch_open_door(level):
	if (door_level == level):
		open()


func _on_Witch_open_door(level):
	if (door_level == level):
		open()

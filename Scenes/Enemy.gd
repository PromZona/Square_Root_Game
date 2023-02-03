extends KinematicBody2D

export var Health: int = 24
export var Speed: int = 100


func _ready():
	$HealthBar.max_value = Health
	$HealthBar.value = Health

func receive_damage(damage: int):
	Health -= damage
	$HealthBar.value = Health
	
	if (Health <= 0):
		hide()

func _process(delta):
	var velocity = Vector2();
	var player = get_node("/root/Main/Charachter")
	velocity = (player.position - position).normalized() * Speed
	move_and_slide(velocity)

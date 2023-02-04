extends KinematicBody2D

class_name Bolt

export var speed: int = 250
export var damage: int = 3

var direction: Vector2 = Vector2(1, 0);

func init(dir: Vector2, pos: Vector2):
	direction = dir
	position = pos 

func _process(delta):
	var velocity = direction * speed * delta
	var target: KinematicCollision2D  = move_and_collide(velocity)
	if target == null:
		return
	var player: Player = target.collider as Player
	if player != null:
		player.damage(damage)
	self.queue_free()

extends Area2D

export var cooldown_time: float = 1.0;
export var force: float = 100.0;

onready var cone: CollisionPolygon2D = $Cone
onready var cooldown: Timer = $Cooldown
onready var particles: Particles2D = $"../Particles2D"

func push_all(current_pos: Vector2):
	if (!cooldown.is_stopped()):
		return
	
	particles.look_at(get_global_mouse_position())
	particles.emitting = true
	var bodies = get_overlapping_bodies()
	for body in bodies:
		var enemy: Enemy = body as Enemy
		if (enemy != null):
			var distance = enemy.global_position - current_pos
			var direction: Vector2 = distance.normalized();
			var velocity: Vector2 = direction * force * (1000.0 / distance.length());
			enemy.push(velocity)
		elif body is Bolt:
			body.queue_free()
		
	cooldown.start(cooldown_time)
	
func _input(event):
	event = event as InputEventMouseMotion
	if event == null:
		return
	look_at(get_global_mouse_position())
	

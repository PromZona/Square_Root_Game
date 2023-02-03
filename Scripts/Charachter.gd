extends KinematicBody2D

export var speed: int = 200;
var velocity: Vector2 = Vector2();

func input():
	# MOVEMENT
	velocity = Vector2()
	if (Input.is_action_pressed("left")):
		velocity.x -= 1
	if (Input.is_action_pressed("right")):
		velocity.x += 1
	if (Input.is_action_pressed("up")):
		velocity.y -= 1
	if (Input.is_action_pressed("down")):
		velocity.y += 1
	velocity = velocity.normalized() * speed;
	
	# ATTACK
	if (Input.is_action_pressed("click_left")):
		$PushAbility.push_all(position)

	
	
func _physics_process(delta: float):
	input()
	velocity = move_and_slide(velocity);

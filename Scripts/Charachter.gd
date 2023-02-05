extends KinematicBody2D

class_name Player

export var speed: int = 200;
export var MaxHealth: int = 50;

onready var push_ability: Area2D = $PushAbility
onready var health_bar: ProgressBar = $HealthBar
onready var health_label: Label = $HealthValue
onready var animation: AnimationPlayer = $AnimationPlayer

var CurrentHealth: int = MaxHealth
var velocity: Vector2 = Vector2();
var spawn_point: Area2D
var enemy = null

func _ready():
	health_bar.value = CurrentHealth
	health_bar.max_value = MaxHealth
	health_label.text = String(CurrentHealth)

func input():
	# MOVEMENT
	velocity = Vector2()
	if (Input.is_action_pressed("left")):
		$Body.flip_h = true;
		velocity.x -= 1
	if (Input.is_action_pressed("right")):
		$Body.flip_h = false;
		velocity.x += 1
	if (Input.is_action_pressed("up")):
		velocity.y -= 1
	if (Input.is_action_pressed("down")):
		velocity.y += 1
	velocity = velocity.normalized() * speed;
	
	
	# ATTACK
	var attack = false
	if (Input.is_action_pressed("click_left")):
		push_ability.push_all(global_position)
		attack = true
	
	if Input.is_action_pressed("click_right"):
		attack = true
		
	
	#ANIMATION
	if attack:
		animation.play("attack")
	elif (velocity.length() != 0):
		animation.play("run")
	elif not animation.current_animation == "attack":
		animation.play("idle")
	

func damage(damage: int):
	CurrentHealth -= damage
	health_bar.value = CurrentHealth
	health_label.text = String(CurrentHealth)
	
	if CurrentHealth <= 0:
		die()
	
func heal(heal: int):
	CurrentHealth += heal
	health_bar.value = CurrentHealth
	health_label.text = String(CurrentHealth)
	
func divide():
	if (CurrentHealth % 2 != 0):
		return
	CurrentHealth /= 2
	health_bar.value = CurrentHealth
	health_label.text = String(CurrentHealth)

func square():
	var sq: float = sqrt(CurrentHealth)
	if (sq != int(sq)):
		return
	CurrentHealth = sq
	health_bar.value = CurrentHealth
	health_label.text = String(CurrentHealth)
	

func die():
	global_position = spawn_point.global_position
	heal(MaxHealth - CurrentHealth)
	if enemy == null:
		return
	enemy.global_position = enemy.SpawnPosition
	enemy.heal(enemy.MaxHealth - enemy.CurrentHealth)

func _physics_process(delta: float):
	input()
	velocity = move_and_slide(velocity);


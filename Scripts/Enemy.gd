extends KinematicBody2D

class_name Enemy

export var MaxHealth: int = 10
export var Speed: int = 100
export var IsWalking: bool = true
export var IsAttacking: bool = true
export var witch_index: int = 0
export var level: int = 1
export var IsActive: bool = false


onready var HealthBar: ProgressBar = $HealthBar
onready var StunTimer: Timer = $Stun
onready var player: KinematicBody2D = $"../../Charachter"
onready var HealthLabel: Label = $HealthValue
onready var shoot_cooldown: Timer = $ShootCooldown
onready var Body: Sprite = $Body

onready var CurrentHealth: int = MaxHealth 
onready var SpawnPosition: Vector2 = global_position

const bullet_blueprint: PackedScene = preload("res://Scenes/Bolt.tscn")

var force_applied: Vector2 = Vector2()
var bullet_counter: int = 0;

signal open_door(level)

func _ready():
	HealthBar.max_value = MaxHealth
	HealthBar.value = CurrentHealth
	HealthLabel.text = String(CurrentHealth)
	
	Body.region_rect.position = Vector2(witch_index * 32, 0)

func damage(damage: int):
	CurrentHealth -= damage
	HealthBar.value = CurrentHealth
	HealthLabel.text = String(CurrentHealth)
	
	if (CurrentHealth > 0):
		return
	
	emit_signal("open_door", level)
	
	self.queue_free()

func push(add_velocity: Vector2):
	force_applied += add_velocity
	IsActive = true
	StunTimer.start()

func _process(delta: float):
	if not IsActive:
		return
	
	# movement
	var velocity = Vector2();
	if (StunTimer.is_stopped()):
		velocity = (player.global_position - global_position).normalized() * Speed
	velocity += force_applied
	move_and_slide(velocity)
		
	if (force_applied.length() > 0):
		force_applied *= 0.9
	
	# shoot
	if IsAttacking and shoot_cooldown.is_stopped():
		shoot()
		shoot_cooldown.start()

func shoot():
	var direction: Vector2 = (player.global_position - global_position).normalized()
	var bolt_pos: Vector2 = position + (direction * 64)
	var bolt = bullet_blueprint.instance()
	get_parent().add_child(bolt)
	bolt.init(direction, bolt_pos)

func heal(heal: int):
	CurrentHealth += heal
	HealthBar.value = CurrentHealth
	HealthLabel.text = String(CurrentHealth)
	
func divide():
	if (CurrentHealth % 2 != 0):
		return
	CurrentHealth /= 2
	HealthBar.value = CurrentHealth
	HealthLabel.text = String(CurrentHealth)

func square():
	var sq: float = sqrt(CurrentHealth)
	if (sq != int(sq)):
		return
	CurrentHealth = sq
	HealthBar.value = CurrentHealth
	HealthLabel.text = String(CurrentHealth)
	

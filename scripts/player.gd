extends CharacterBody2D

class_name Player

const SPEED = 950.0
const JUMP_SPEED = -2450.0
const BOOST_SPEED = 5000.0
const BOOST_ACCEL = 4000

const ACCELERATION = 60
const FRICTION = 75

const GRAVITY = 200

var REMAINING_BOOSTS = 1
var CURRENT_JUMPS = 1
var hp
@onready var anim=get_node("AnimatedSprite2D")
func _ready():
	anim.play("Idle")
	hp = 5
	
# Get the gravity from the project settings to be synced with RigidBody nodes.
func _physics_process(delta):
	var input_dir: Vector2 = input()
	if input_dir.x < 0:
		$AnimatedSprite2D.flip_h = true
		$Head/WinkyHorns.flip_h=true
		$Head/eyeball.position.x=-51
	elif input_dir.x > 0:
		$AnimatedSprite2D.flip_h = false
		$Head/WinkyHorns.flip_h=false
		$Head/eyeball.position.x=0
		
	
	
	if input_dir != Vector2.ZERO && !beyond_top_speed():
		add_acceleration(input_dir)
		anim.play("Run")
		$Head.position.y=15
		boost(input_dir)
	else:
		add_friction()
		anim.play("Idle")
		$Head.position.y=0
	jump()
	player_movement()
	
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir = input_dir.normalized()
	
	return input_dir
	
func add_acceleration(direction: Vector2):
	velocity = velocity.move_toward(SPEED * direction, ACCELERATION)
	
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

func boost(direction: Vector2):
	if Input.is_action_just_pressed("boost"):
		velocity = velocity.move_toward(BOOST_SPEED * direction, BOOST_ACCEL)

	
func jump():
	if Input.is_action_just_pressed("jump"):
		if CURRENT_JUMPS > 0:
			CURRENT_JUMPS -= 1
			velocity.y = JUMP_SPEED
	elif beyond_top_speed():
		return
	else:
		velocity.y += GRAVITY
	if is_on_floor():
		CURRENT_JUMPS = 1
			

func beyond_top_speed() -> bool:
	return abs(velocity.x) > SPEED
	
func player_movement():
	move_and_slide()
func apply_damage():
	hp -= 1
	print("Player took damage! current hp: ", hp)

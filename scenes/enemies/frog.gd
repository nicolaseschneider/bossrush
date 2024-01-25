extends CharacterBody2D

class_name Enemy

@export var Bullet : PackedScene

const SPEED = 250
const JUMP_VELOCITY = -2000
var player_position
var health
@onready var player = get_parent().get_node("Player")
@onready var anim=get_node("AnimatedSprite2D")

# Get the gravity from the project settings to be synced with RigidBody nodes.
const gravity = 7000

var move_dir = 1 # what direction the frog will move.

var state: String

func _ready():
	state = "JUMP"
	health = 20

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.x = SPEED * move_dir
	else:
		if state == "JUMP":
			anim.play("jump")
			state = "SHOOT"
			move_dir = get_player_direction_x()
			jump()
		else:
			shoot()
			# set a timer for the animation duraton before changing state again
			state = "JUMP"
	move_and_slide()


func jump():
	velocity.y += JUMP_VELOCITY

func get_player_direction_x():
	#probably a better way to do this, but i cant be assed to read the docs rn
	if player.position.x - position.x > 0:
		return 1
	else:
		return -1

func shoot():
	var b = Bullet.instantiate()
	b.position = position
	get_parent().add_child(b)
	
func apply_damage():
	health -= 1
	if health <= 0: 
		anim.play("Death")
		queue_free()
		

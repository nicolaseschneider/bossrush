extends Area2D

const SHOT_SPEED = 600
var move_direction = 1

@onready var player = get_parent().get_node("Player")

func _ready():
	$Timer.one_shot = true
	$Timer.autostart = true
	$Timer.wait_time = 3.0 # however long the animation is
	$Timer.connect("timeout", self.queue_free)
	move_direction = get_player_direction_x()
	body_entered.connect(on_body_entered)

func _physics_process(delta):
	position.x += move_direction * SHOT_SPEED * delta

func get_player_direction_x():
	#probably a better way to do this, but i cant be assed to read the docs rn
	if player.position.x - position.x > 0:
		return 1
	else:
		return -1

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body as Player
		player.apply_damage()
		queue_free()

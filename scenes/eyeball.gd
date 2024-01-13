extends CharacterBody2D

@export var Bullet : PackedScene

func _physics_process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.position = Vector2(140, 0)
	
	print(b.position)

extends Area2D

func _ready():
	$Timer.one_shot = true
	$Timer.autostart = true
	$Timer.wait_time = 2.0 # however long the animation is
	$Timer.connect("timeout", self.queue_free)
	body_entered.connect(on_body_entered)

func _on_Bullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
	queue_free()

func on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		var enemy: Enemy = body as Enemy
		enemy.apply_damage()

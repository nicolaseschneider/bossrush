extends Area2D

#working on this, but can't figure out why the variable is set to true on scene init.
@onready var entered = false

func _on_body_entered(body: PhysicsBody2D):
	entered = true
	print("entered")
		
		
		
func _on_body_exited(body):
	entered = false
	print("entered false")
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file #change scene to Gorbo Scene
			print("change scene complete")

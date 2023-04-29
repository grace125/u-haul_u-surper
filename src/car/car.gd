class_name Car extends RigidBody2D

@export var speed = 40

func _physics_process(delta):
	var input_direction: Vector2 = Input.get_vector("Left", "Right", "Forward", "Backward")
	apply_central_force(input_direction * speed)

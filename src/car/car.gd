class_name Car extends RigidBody2D

@export var speed = 1.0
@export var steering = 1.0

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	var input_direction: Vector2 = Input.get_vector("Left", "Right", "Forward", "Backward")
	var torque = input_direction.x
	var f = input_direction.y
	var rotation_direction = Vector2(0.0, 1.0).rotated(rotation)
	if torque != 0.0:
		apply_torque(torque * 5000000.0 * steering)
		
	if f != 0.0:
		apply_central_force(speed * 800000 * rotation_direction * f)
	

	
	
func _process(delta):
	
	$AnimatedSprite2D.speed_scale = linear_velocity.length()

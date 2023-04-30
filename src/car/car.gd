class_name Car extends RigidBody2D

@export var speed = 1.0
@export var steer_speed = 1.0

var last_steer_control: float = 0.0;
var last_contact_count: float = 0.0;
var v0: Vector2 = linear_velocity;
var linear_acceleration: Vector2 = Vector2.ZERO;

signal shake(Vector2);

# Emits on change of turning
# control: -1 if left, 0 of nothing, and 1 if right
# steer_speed: the steer speed modifier (the variable exported above)
signal turning(control: int, steer_speed: float);

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	var input_direction: Vector2 = Input.get_vector("Left", "Right", "Forward", "Backward")
	var steer_control = input_direction.x
	var forward_control = input_direction.y
	var rotation_direction = Vector2(0.0, 1.0).rotated(rotation)
	
	if steer_control != 0.0:
		apply_torque(steer_control * 5000000.0 * steer_speed);
	if forward_control != 0.0:
		apply_central_force(speed * 800000.0 * rotation_direction * forward_control)
		
	if _normalize(steer_control) != last_steer_control:
		last_steer_control = _normalize(steer_control)
		turning.emit(last_steer_control, steer_speed)
	

	
func _process(delta):
	var rotation_direction = Vector2(0.0, 1.0).rotated(rotation)
	$AnimatedSprite2D.speed_scale = linear_velocity.dot(rotation_direction)
	
	linear_acceleration = (linear_velocity - v0) / delta
	v0 = linear_velocity

func _normalize(x: float):
	if x < 0.0:
		return -1
	elif x > 0.0:
		return 1
	else:
		return 0

func _on_body_entered(body):
	var force: Vector2;
	if "linear_acceleration" in body \
		and "mass" in body \
		and body.linear_acceleration is Vector2 \
		and body.mass is float:
			force = body.mass * (body.linear_acceleration - linear_acceleration) 
	else:
		# assume the object collided with is a static body
		force = mass * -linear_velocity * 60.0
	
	shake.emit(force)
	# print(force)
	

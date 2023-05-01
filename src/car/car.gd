class_name Car extends RigidBody2D

@export var speed = 1.0
@export var steer_speed = 1.0
@export var waypoint_distance_threshold: float = 800.0

var waypoints_list: Array #Set by the enemy_cars node
var current_waypoint_index: int = 0
var potential_lap_counter: int = 0
var laps_finished: int = 0

const BOX = preload("res://src/race_interactables/box.tscn")

var last_steer_control: float = 0.0;
var last_contact_count: float = 0.0;
var v0: Vector2 = linear_velocity;
var linear_acceleration: Vector2 = Vector2.ZERO;
var r0: float = angular_velocity;

@export var start_flag: bool = false

signal shake(Vector2);

# Emits on change of turning
# control: -1 if left, 0 of nothing, and 1 if right
# steer_speed: the steer speed modifier (the variable exported above)
signal turning(velocity: float);

signal lap_finished();

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	if global_position.distance_to(waypoints_list[current_waypoint_index]) <= waypoint_distance_threshold:
		current_waypoint_index += 1
		if current_waypoint_index >= len(waypoints_list):
			current_waypoint_index = 0
			potential_lap_counter += 1
			
	
	var input_direction: Vector2;
	if start_flag:
		input_direction = Input.get_vector("Left", "Right", "Forward", "Backward")
	else:
		input_direction = Vector2.ZERO
	var steer_control = input_direction.x
	var forward_control = input_direction.y
	var rotation_direction = Vector2(0.0, 1.0).rotated(rotation)
	
	if steer_control != 0.0:
		apply_torque(steer_control * 5000000.0 * steer_speed);
	if forward_control != 0.0:
		apply_central_force(speed * 800000.0 * rotation_direction * forward_control)
		
	# if _normalize(steer_control) != last_steer_control:
	# 	last_steer_control = _normalize(steer_control)
	# 	turning.emit(last_steer_control, steer_speed*50.0)
	
func _process(delta):
	var rotation_direction = Vector2(0.0, 1.0).rotated(rotation)
	$AnimatedSprite2D.speed_scale = linear_velocity.dot(rotation_direction)
	
	linear_acceleration = (linear_velocity - v0) / delta
	
	if angular_velocity != r0:
		turning.emit(r0)
		r0 = angular_velocity

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
	
	shake.emit(force / 80000.0)


func spawn_box(left: bool):
	var box = BOX.instantiate()
	if left:
		box.position = position - Vector2(15.0, 0.0).rotated(rotation)
		box.linear_velocity = - 4*Vector2(15.0, 0.0).rotated(rotation)
	else:
		box.position = position + Vector2(15.0, 0.0).rotated(rotation)
		box.linear_velocity = 4*Vector2(15.0, 0.0).rotated(rotation)
	get_parent().add_child(box)
	
func on_race_start():
	start_flag = true

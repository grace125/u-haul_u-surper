class_name EnemyCar extends RigidBody2D

@export var speed: float = 30.0
@export var max_speed: float = 110.0
@export var waypoint_distance_threshold: float = 40.0
@export var car_color: Color

@onready var sprite = $AnimatedSprite2D

var waypoints_list: Array #Set by the enemy_cars node
var current_waypoint_index: int = 0

func _process(delta):
	var rotation_direction = Vector2(0.0, 1.0).rotated(rotation)
	sprite.speed_scale = linear_velocity.dot(rotation_direction)

func _ready():
	sprite.play()
	sprite.modulate = car_color

func _physics_process(delta):
	if global_position.distance_to(waypoints_list[current_waypoint_index]) <= waypoint_distance_threshold:
		current_waypoint_index += 1
		if current_waypoint_index >= len(waypoints_list):
			current_waypoint_index = 0
		print("current_waypoint_index ", current_waypoint_index, " ", waypoints_list[current_waypoint_index])
	if linear_velocity.length() < max_speed:
		apply_central_force(800000.0 * global_position.direction_to(waypoints_list[current_waypoint_index]) * speed * delta)
	if linear_velocity != Vector2.ZERO:
		rotation = Vector2(0.0, -1.0).angle_to(linear_velocity)
	
	

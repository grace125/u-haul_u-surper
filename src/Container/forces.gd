extends StaticBody2D

func turning(direction: int, velocity: float):
	match direction:
		-1:
			constant_linear_velocity.x = -velocity
		0:
			constant_linear_velocity.x = 0
		1:
			constant_linear_velocity.x = velocity

var collision_time = 0.0

func collision(force: Vector2):
	constant_linear_velocity.x = force.x
	constant_linear_velocity.y = -abs(force.y)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	collision_time += delta
	if collision_time > 1:
		collision_time = 0.0
		collision(Vector2(0,0))
	

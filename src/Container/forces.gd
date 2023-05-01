extends StaticBody2D

func turning(velocity: float):
		constant_linear_velocity.x = velocity*15

var collision_time = 0.0

func collision(force: Vector2):
	constant_linear_velocity.x = force.x
	constant_linear_velocity.y = -abs(force.y)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (collision_time > 0.25) && (constant_linear_velocity.y != 0.0):
		collision_time = 0.0
		collision(Vector2(0,0))
	else: collision_time += delta
	

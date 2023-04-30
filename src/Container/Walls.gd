extends StaticBody2D


func turning(direction: int, velocity: float):
	match direction:
		-1:
			constant_linear_velocity.x = -velocity
		0:
			constant_linear_velocity.x = 0
		1:
			constant_linear_velocity.x = velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

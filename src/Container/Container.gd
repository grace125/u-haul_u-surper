extends Node2D

func turning(direction: int, velocity: float):
	$floor.turning(direction, velocity)
	$ceiling.turning(direction, velocity)

func shake(vec: Vector2):
	$floor.collision(vec)
	$ceiling.collision(vec)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

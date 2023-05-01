extends Node2D

signal spawn_box(left: bool)

func turning(velocity: float):
	$floor.turning(velocity)

func shake(vec: Vector2):
	$floor.collision(vec)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_left(body: Node2D):
	print("OOOOOO")
	body.queue_free()
	spawn_box.emit(true)
	
func spawn_right(body: Node2D):
	print("AAAAAA")
	body.queue_free()
	spawn_box.emit(false)

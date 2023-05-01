class_name OverworldBox extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("roll")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var flipped;
	if $AnimatedSprite2D.flip_h:
		flipped = -1
	else:
		flipped = 1
	$AnimatedSprite2D.speed_scale = linear_velocity.dot(Vector2(1.0, 0.0))/10.0
	if $AnimatedSprite2D.speed_scale < 0.0:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.speed_scale *= -1
	else:
		$AnimatedSprite2D.flip_h = false

func _integrate_forces(state):
	rotation = 0;

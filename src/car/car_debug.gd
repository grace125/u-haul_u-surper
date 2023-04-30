extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_turning(control, steer_speed):
	print("Turn change: " + str(control) + ", " + str(steer_speed))

func _on_car_shake(vec: Vector2):
	print("Car Shake: " + str(vec))

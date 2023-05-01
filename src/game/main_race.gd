extends Node2D

@onready var car = $CanvasLayer1/car
@onready var rivers = $CanvasLayer1/testing_track/river
@onready var road = $CanvasLayer1/testing_track/road

# Called when the node enters the scene tree for the first time.
func _ready():
	rivers.car_fallen_in_river.connect(car_river_moment)
	road.body_entered.connect(road_entered)
	road.body_exited.connect(road_exited)

func car_river_moment():
	print("game over!")
	
func road_exited(node):
	if node == car:
		car.linear_damp = 4;
		car.angular_damp = 4;
	
func road_entered(node):
	if node == car:
		car.linear_damp = 1;
		car.angular_damp = 1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

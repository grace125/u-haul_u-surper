extends Node2D

@onready var car = $CanvasLayer1/testing_track/enemy_cars/enemy_cars_holder/car
@onready var rivers = $CanvasLayer1/testing_track/river
@onready var road = $CanvasLayer1/testing_track/road
@onready var finish_line = $CanvasLayer1/testing_track/finish_line

# Called when the node enters the scene tree for the first time.
func _ready():
	rivers.car_fallen_in_river.connect(car_river_moment)
	road.body_entered.connect(road_entered)
	road.body_exited.connect(road_exited)

func car_river_moment():
	get_tree().change_scene_to_file("res://src/game_over/game_over.tscn")
	
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

extends Node2D

@onready var enemy_cars_holder = $enemy_cars_holder
@onready var waypoints_path = $Path2D


func _ready():
	var waypoints_list: Array = []
	for i in range(waypoints_path.curve.point_count):
		waypoints_list.append(waypoints_path.curve.get("point_" + str(i) + "/position"))
	print("waypoints_list ", waypoints_list)
	for i in enemy_cars_holder.get_children():
		i.waypoints_list = waypoints_list

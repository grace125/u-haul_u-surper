class_name River extends Node2D

signal car_fallen_in_river


func _on_part_1_body_entered(body):
	if body is Car:
		emit_signal("car_fallen_in_river")


func _on_part_2_body_entered(body):
	if body is Car:
		emit_signal("car_fallen_in_river")


func _on_part_3_body_entered(body):
	if body is Car:
		emit_signal("car_fallen_in_river")

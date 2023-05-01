extends Area2D

@export var num_laps: int = 2

var num_cars_finished: int = 0

signal race_finished(place: int);


func _on_body_entered(body):
	print("AAAAA")
	if body is Car or body is EnemyCar:
		print("BBBBB")
		print(body.potential_lap_counter)
		if body.potential_lap_counter > 0:
			print("CCCCC")
			body.potential_lap_counter -= 1
			body.laps_finished += 1
			print(body.laps_finished)
			body.lap_finished.emit()
			if body.laps_finished == num_laps:
				print("DDDDD")
				num_cars_finished += 1
				if body is Car:
					print("EEEEE")
					race_finished.emit(num_cars_finished)
			
			

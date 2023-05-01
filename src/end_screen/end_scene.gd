extends Control

var score: int = 0
var place: int = 0
var boxes_left: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Place.text += str(place)
	$Score.text += str(score)
	$Boxes.text += str(boxes_left)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://src/game/main_race.tscn")

extends Control

func _ready():
	Music.play_song("ThemeSong_1", Music.DEFAULT_MUSIC_VOLUME, 0.2)
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://src/racetracks/testing_track.tscn")

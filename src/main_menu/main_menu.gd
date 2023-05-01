extends Control

func _ready():
	Music.play_song("Title_Theme_2", Music.DEFAULT_MUSIC_VOLUME, 0.2)

func _on_button_pressed():
	Music.play_song("ThemeSong_1", Music.DEFAULT_MUSIC_VOLUME, 0.2)
	get_tree().change_scene_to_file("res://src/game/main_race.tscn")

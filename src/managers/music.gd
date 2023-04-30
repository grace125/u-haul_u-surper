extends Node

onready var music_player = $music_player
onready var tween = $Tween

const MUSIC_DIRECTORY_PATH = "res://assets/audio/music/"
const DEFAULT_MUSIC_VOLUME: float = -20.0
const DEFAULT_CROSSFADE_TIME: float = 0.4
const MUSIC_CROSSFADE_TWEEN_TRANS := Tween.TRANS_SINE
const MUSIC_CROSSFADE_TWEEN_EASE := Tween.EASE_IN

var music_files: Dictionary = {}
var current_song: String = ""

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	_rng.randomize()
	set_up_music_library_recursive(MUSIC_DIRECTORY_PATH)


func set_up_music_library_recursive(directory_path: String) -> void:
	var dir = Directory.new()
	if dir.open(directory_path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name.left(1) != ".":
				set_up_music_library_recursive(directory_path + file_name + "/")
			elif not dir.current_is_dir() and file_name.ends_with(".wav.import") or file_name.ends_with(".ogg.import"):
				var file_name2 = file_name.replace(".import", "")
				var music_name = file_name
				music_name.erase(music_name.length() - 11, 11)
				music_files[music_name] = (load(directory_path + file_name2))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path: ", directory_path)


# Default use: Music.play_song("", Music.DEFAULT_MUSIC_VOLUME, Music.DEFAULT_CROSSFADE_TIME)
func play_song(new_song: String, volume: float = DEFAULT_MUSIC_VOLUME, fade_duration: float = DEFAULT_CROSSFADE_TIME) -> void:
	if new_song != current_song:
		tween.interpolate_property(music_player, "volume_db", null, -80, fade_duration, MUSIC_CROSSFADE_TWEEN_TRANS, MUSIC_CROSSFADE_TWEEN_EASE)
		tween.start()
		yield(tween, "tween_completed")
		current_song = new_song
		music_player.stream = music_files[new_song]
		music_player.play()
		tween.interpolate_property(music_player, "volume_db", -80, volume, fade_duration, MUSIC_CROSSFADE_TWEEN_TRANS, MUSIC_CROSSFADE_TWEEN_EASE)
		tween.start()


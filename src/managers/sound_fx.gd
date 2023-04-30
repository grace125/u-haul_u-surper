extends Node

@onready var audio_players = $audio_players
@onready var audio_players_list = audio_players.get_children()

const SOUND_FX_DIRECTORY_PATH = "res://assets/audio/sound_effects/"
const SOUND_FX_VOLUME: float = -4.0

var sound_fx_files: Dictionary = {}

#var _crng = CustomRandomGenerator.new()
var _rng = RandomNumberGenerator.new()


func _ready() -> void:
	_rng.randomize()
	set_up_sound_effects_library_recursive(SOUND_FX_DIRECTORY_PATH)


func set_up_sound_effects_library_recursive(directory_path: String) -> void:
	var dir = DirAccess.open(directory_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name.left(1) != ".":
				set_up_sound_effects_library_recursive(directory_path + file_name + "/")
			elif not dir.current_is_dir() and file_name.ends_with(".wav.import") or file_name.ends_with(".ogg.import"):
				var file_name2 = file_name.replace(".import", "")
				var sound_name = file_name
				sound_name = sound_name.trim_suffix(".wav.import")
				sound_name = sound_name.trim_suffix(".ogg.import")
				sound_fx_files[sound_name] = (load(directory_path + file_name2))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path: ", directory_path)


# Default use: Sfx.play_sfx("", 0.0, 1.0, Sfx.SOUND_FX_VOLUME)
func play_sfx(sound_name: String, pitch_range: float = 0.0, pitch: float = 1.0, volume: float = SOUND_FX_VOLUME):
	for i in audio_players_list:
		if not i.playing:
			i.stream = sound_fx_files[sound_name]
			i.volume_db = volume
			i.pitch_scale = _rng.randf_range(pitch - pitch_range, pitch + pitch_range)
			i.play()
			break


#func play_random_sfx(weighted_sound_list: Array, pitch_range: float = 0.0, pitch: float = 1.0, volume: float = SOUND_FX_VOLUME):
#	var sound_name = _crng.weighted_list_randomization(weighted_sound_list)
#	play_sfx(sound_name, pitch_range, pitch, volume)


func stop_sfx(sound_name: String, stop_all: bool = false) -> void:
	for i in audio_players_list:
		if i.stream == sound_fx_files[sound_name]:
			i.stop()
			if not stop_all:
				break


func stop_all_sfx() -> void:
	for i in audio_players_list:
		if i.stream != null and i.stream.loop_mode != 0:
			i.stop()


func get_audio_stream(sound_name: String) -> AudioStream:
	assert(sound_name in sound_fx_files, "Nonexistant sound effect.")
	return sound_fx_files[sound_name]

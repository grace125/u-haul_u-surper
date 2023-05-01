extends Label

signal start_race

@onready var timer_321 = $"321_timer"

var countdown: int = 3

func _ready():
	SFX.play_sfx("race_start_beep_1")

func _on_321_timer_timeout():
	countdown -= 1
	if countdown <= 0:
		SFX.play_sfx("race_start_beep_2")
		text = "GO!"
		emit_signal("start_race")
		await get_tree().create_timer(1.5).timeout
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 2.5)
		return
	SFX.play_sfx("race_start_beep_1", 0.01)
	text = str(countdown)
	timer_321.start()
